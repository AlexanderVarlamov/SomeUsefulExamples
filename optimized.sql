WITH dates AS (
  SELECT
    TO_DATE(SUBSTR('29991231', 1, 8), 'YYYYMMDD') + INTERVAL '1 day - 1 second' as AS end_date,
    CAST(SUBSTR('20230101', 1, 6) AS INT) AS month_id
), tu AS (
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000048_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000049_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000050_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000051_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000052_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000053_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000054_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000055_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000056_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000057_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000058_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000059_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000060_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000061_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
  UNION ALL
  SELECT
    CAST(ROUND(t.user_type_id) AS VARCHAR) AS user_type_id,
    ROUND(t.user_id) AS user_id,
    ROUND(t.dept_id) AS dept_id,
    CAST(ROUND(t.dept_id) AS VARCHAR) AS dept_id_,
    ROUND(t.billing_id) AS billing_id,
    t.src_id
  FROM EDW_ODS.t_000062_t_saldo AS t
  JOIN dates AS d
    ON t.billing_id <= d.month_id AND t.tech_dt <= d.end_date
), utr AS (
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000048_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000049_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000050_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000051_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000052_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000053_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000054_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000055_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000056_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000057_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000058_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000059_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000060_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000061_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
  UNION ALL
  SELECT
    ROUND(tr.coef) AS coef,
    CAST(ROUND(tr.user_type_id) AS VARCHAR) AS user_type_id,
    tr.src_id
  FROM EDW_ODS.t_000062_t_user_type_ref AS tr
  JOIN dates AS d
    ON tr.deleted_ind = 0 AND d.end_date BETWEEN tr.eff_dttm AND tr.exp_dttm
), hub AS (
  SELECT
    CAST(h.source_key AS VARCHAR),
    h.branch_key,
    h.src_id
  FROM edw_dds.hub_dim_branch AS h
  JOIN dates AS d
    ON h.src_id BETWEEN 48 AND 62 AND d.end_date BETWEEN h.eff_dttm AND h.exp_dttm
), ttr AS (
  SELECT
    tu.user_type_id,
    tu.user_id,
    tu.dept_id,
    tu.billing_id,
    utr.coef,
    hub.branch_key,
    tu.src_id
  FROM tu
  LEFT JOIN utr
    ON 1 = 1 AND utr.user_type_id = tu.user_type_id AND utr.src_id = tu.src_id
  LEFT JOIN hub
    ON 1 = 1 AND tu.dept_id_ = hub.source_key AND hub.src_id = tu.src_id
), t_saldo AS (
  SELECT
    sl.*,
    COALESCE(
      CASE
        WHEN sl.billing_id = sl.min_billing_id
        OR (
          sl.billing_id IS NULL AND sl.min_billing_id IS NULL
        )
        THEN TO_DATE('19000101', 'YYYYMMDD')
      END,
      billing_id_
    ) AS start_date,
    COALESCE(
      CASE
        WHEN sl.billing_id = sl.max_billing_id
        OR (
          sl.billing_id IS NULL AND sl.max_billing_id IS NULL
        )
        THEN TO_DATE('29991231', 'YYYYMMDD')
      END,
      billing_id_ + INTERVAL '1 month - 1 day'
    ) AS end_date
  FROM (
    SELECT
      CAST(ROUND(s.user_type_id) AS VARCHAR) AS user_type_id,
      ROUND(s.billing_id) AS billing_id,
      TO_DATE(CAST(s.billing_id AS VARCHAR), 'MM') AS billing_id_,
      ROUND(s.dept_id) AS dept_id,
      s.user_id,
      MAX(s.billing_id) OVER (PARTITION BY s.user_id) AS max_billing_id,
      MIN(s.billing_id) OVER (PARTITION BY s.user_id) AS min_billing_id
    FROM EDW_ODS.t_009999_t_saldo AS s
    JOIN dates AS d
      ON 1 = 1 AND s.billing_id <= d.month_id AND s.tech_dt <= end_date
  ) AS sl
), t_users AS (
  SELECT
    u.user_id,
    ROUND(u.dept_id) AS dept_id,
    CAST(u.user_type_id AS VARCHAR),
    u.chief_user_id,
    u.inn,
    u.kpp,
    u.name,
    u.document_text,
    u.src_id,
    u.eff_dttm,
    u.exp_dttm
  FROM EDW_ODS.t_009999_t_users AS u
  JOIN dates AS d
    ON 1 = 1 AND d.end_date BETWEEN u.eff_dttm AND u.exp_dttm AND u.deleted_ind = 0
), t_chief_users AS (
  SELECT
    u.user_id,
    u.inn
  FROM EDW_ODS.t_009999_t_users AS u
  JOIN dates AS d
    ON 1 = 1 AND u.deleted_ind = 0 AND d.end_date BETWEEN u.eff_dttm AND u.exp_dttm
), t_vip_sp AS (
  SELECT
    ROUND(sp.user_id_sp) AS user_id_sp,
    ROUND(v.user_id_vip) AS user_id_vip,
    ROUND(sp.dept_id_vip) AS dept_id_vip,
    CAST(ROUND(sp.dept_id_vip) AS TEXT) AS dept_id_vip_,
    CASE
      WHEN COALESCE(v.date_begin, TO_DATE('19000101', 'YYYYMMDD')) = MIN(COALESCE(v.date_begin, TO_DATE('19000101', 'YYYYMMDD'))) OVER (PARTITION BY v.user_id_sp)
      THEN TO_DATE('19000101', 'YYYYMMDD')
      ELSE COALESCE(v.date_begin, TO_DATE('19000101', 'YYYYMMDD'))
    END AS date_begin_v2,
    CASE
      WHEN COALESCE(v.date_end, TO_DATE('29991231', 'YYYYMMDD')) = MAX(COALESCE(v.date_end, TO_DATE('29991231', 'YYYYMMDD'))) OVER (PARTITION BY v.user_id_sp)
      THEN TO_DATE('29991231', 'YYYYMMDD')
      ELSE COALESCE(v.date_end, TO_DATE('29991231', 'YYYYMMDD'))
    END AS date_end_v2
  FROM EDW_ODS.t_009999_t_vip_sp AS sp
  JOIN (
    SELECT
      v.user_id_vip,
      v.user_id_sp,
      v.date_begin,
      v.date_end,
      ROW_NUMBER() OVER (PARTITION BY USER_ID_VIP, DEPT_ID_SP, USER_ID_SP ORDER BY date_begin DESC NULLS FIRST) AS rn
    FROM edw_ods.t_009999_t_vip AS v
    JOIN dates AS d
      ON 1 = 1 AND d.end_date BETWEEN v.eff_dttm AND v.exp_dttm AND v.deleted_ind = 0
  ) AS v
    ON 1 = 1 AND sp.user_id_sp = v.user_id_sp AND sp.deleted_ind = 0 AND v.rn = 1
  JOIN dates AS d
    ON 1 = 1 AND d.end_date BETWEEN sp.eff_dttm AND sp.exp_dttm
), main AS (
  SELECT
    tu.user_id AS partner_key,
    tcu.inn AS parent_tax_number_cval,
    tu.inn AS tax_number_cval,
    COALESCE(ttr.user_type_id, s.user_type_id, tu.user_type_id, 'ND_EKHD') AS segment_key, /* old: coalesce(round(s.user_type_id)::varchar, tu.user_type_id::varchar, 'ND_EKHD') as segment_key, */
    COALESCE(s.dept_id, tu.dept_id) AS branch_key,
    tu.kpp AS tax_reg_reason_cval,
    tu.name AS partner_full_name,
    tu.document_text AS doc_number_cval,
    tu.src_id AS src_id,
    COALESCE(s.start_date, TO_DATE('19000101', 'YYYYMMDD')) AS start_date,
    COALESCE(s.end_date, TO_DATE('29991231', 'YYYYMMDD')) + INTERVAL '1 day - 1 second' as AS end_date
  FROM t_users AS tu
  LEFT JOIN t_saldo AS s
    ON 1 = 1 AND tu.user_id = s.user_id
  LEFT JOIN t_chief_users AS tcu
    ON 1 = 1 AND tcu.user_id = tu.chief_user_id
  LEFT JOIN t_vip_sp AS tvs
    ON 1 = 1
    AND tu.user_id = tvs.user_id_sp
    AND s.billing_id_ BETWEEN tvs.date_begin_v2 AND tvs.date_end_v2
  LEFT JOIN hub
    ON 1 = 1 AND tvs.dept_id_vip_ = hub.source_key AND tu.src_id = hub.src_id
  LEFT JOIN ttr
    ON ttr.user_id = tvs.user_id_vip
    AND hub.branch_key = ttr.branch_key
    AND s.billing_id = ttr.billing_id
)
SELECT
  partner_key,
  parent_tax_number_cval,
  tax_number_cval,
  segment_key,
  branch_key,
  tax_reg_reason_cval,
  partner_full_name,
  doc_number_cval,
  src_id,
  CURRENT_TIMESTAMP() AS load_dttm,
  start_date AS eff_dttm,
  CASE
    WHEN TIMESTAMP_TRUNC(end_date, day) = TO_DATE('29991231', 'YYYYMMDD')
    THEN CAST(TIMESTAMP_TRUNC(end_date, day) AS TIMESTAMP)
    ELSE end_date
  END AS exp_dttm,
  start_date,
  CASE
    WHEN TIMESTAMP_TRUNC(end_date, day) = TO_DATE('29991231', 'YYYYMMDD')
    THEN CAST(TIMESTAMP_TRUNC(end_date, day) AS TIMESTAMP)
    ELSE end_date
  END AS end_date
FROM main