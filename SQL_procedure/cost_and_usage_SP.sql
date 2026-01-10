CREATE OR REPLACE PROCEDURE procedure_dev.finalize_monthly_cost(
    IN p_year INT,
    IN p_month INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Prevent duplicate monthly load
    IF EXISTS (
        SELECT 1 FROM certified_monthly_cost
        WHERE year = p_year AND month = p_month
    ) THEN
        RAISE EXCEPTION 'Month %-% already finalized', p_year, p_month;
    END IF;

    INSERT INTO certified_monthly_cost
    SELECT
        line_item_usage_account_id,
        line_item_usage_account_name,
        product_product_family,
        product_servicecode,
        product_usagetype,
        line_item_line_item_description,
        line_item_unblended_rate,
        SUM(line_item_usage_amount) AS total_usage_amount,
        SUM(CASE WHEN line_item_line_item_type = 'SavingsPlanCoveredUsage' THEN pricing_public_on_demand_cost ELSE 0 END) AS sp_covered_cost,
        SUM(CASE WHEN line_item_line_item_type = 'EdpDiscount' THEN ABS(line_item_unblended_cost) ELSE 0 END) AS edp_discount,
        SUM(CASE WHEN line_item_line_item_type = 'SppDiscount' THEN ABS(line_item_unblended_cost) ELSE 0 END) AS spp_discount,
        SUM(CASE WHEN line_item_line_item_type = 'Credit' THEN line_item_unblended_cost ELSE 0 END) AS credit_amount,
        SUM(line_item_unblended_cost) AS total_unblended_cost,
        SUM(CASE WHEN line_item_line_item_type = 'SavingsPlanCoveredUsage' THEN pricing_public_on_demand_cost ELSE 0 END) +
        SUM(CASE WHEN line_item_line_item_type = 'EdpDiscount' THEN ABS(line_item_unblended_cost) ELSE 0 END) +
        SUM(CASE WHEN line_item_line_item_type = 'SppDiscount' THEN ABS(line_item_unblended_cost) ELSE 0 END) +
        SUM(CASE WHEN line_item_line_item_type = 'Credit' THEN ABS(line_item_unblended_cost) ELSE 0 END) +
        SUM(line_item_unblended_cost) AS total_cost_before_discount,
        p_year AS year,
        p_month AS month
    FROM <staging_schema>.<staging_table>
    WHERE year = p_year AND month = p_month
    GROUP BY
        line_item_usage_account_id,
        line_item_usage_account_name,
        product_product_family,
        product_servicecode,
        product_usagetype,
        line_item_line_item_description,
        line_item_unblended_rate;
END;
$$;

