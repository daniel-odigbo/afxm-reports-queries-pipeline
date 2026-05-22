SELECT
    e.parent_id,
    e.sol_id,
    e.dc_ref_num,
    custom.all_report_functions.get_employee_name(e.primary_rm)
        AS product_manager_desc,
    custom.all_report_functions.get_rct_desc(
        e.risk_country_code,
        '03'
    ) country,
    CASE
        WHEN UPPER(
            custom.all_report_functions.get_crm_clang_desc(
                e.cust_const,
                'CONSTITUTION_CODE'
            )
        ) IN (
            'LIMITED LIABILITY COMPANY',
            'PRIVATE COMPANY LIMITED BY SHARES (LTD)'
        )
        THEN 'PRIVATE'
        WHEN UPPER(
            custom.all_report_functions.get_crm_clang_desc(
                e.cust_const,
                'CONSTITUTION_CODE'
            )
        ) IN (
            'CENTRAL BANK',
            'MINISTRY',
            'PARASTATAL'
        )
        THEN 'SOVEREIGN'
        ELSE 'PUBLIC'
    END borrower_type
FROM custom.v_enriched_dcmm e;
