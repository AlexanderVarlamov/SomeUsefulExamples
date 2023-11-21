SELECT
  "CM"."COMM_ID" AS "NETWORK_ELEMENT_KEY", /* ok */
  COALESCE(
    CASE
      WHEN "CM"."COMM_PRNT_ID" > 0
      THEN "CM"."COMM_PRNT_ID"
      WHEN "CM"."ADROBJECT_TYPE" = 1
      THEN "CM"."ADROBJECT_ID"
      WHEN "CM"."ADROBJECT_TYPE" = 2
      THEN "CM"."ADROBJECT_ID"
    END,
    '-1'
  ) AS "NETWORK_PARENT_DEVICE_KEY", /* ok */
  CAST("MR"."TYPDEVICE_KOD" AS VARCHAR) AS "NETWORK_ELEMENT_TYPE_KEY", /* ok */ /* ,cm.invproj_id    as project_key */
  "CM"."DATEV" AS "INSTALL_DT", /* ok */
  CONCAT(
    CASE
      WHEN "CM"."COMM_PRNT_ID" = 0 AND "RH"."RH_ID" > 0
      THEN CONCAT("RH"."NUMB", ' ')
    END,
    "CM"."NUMB"
  ) AS "NETWORK_ELEMENT_NAME",
  COALESCE("CM"."SOSTLOG_KOD", '-1') AS "EQUIPMENT_STATUS_KEY", /* ok */ /* ,sn.invn          as inventory_num */ /* ,vn.vendor_name   as equipment_brand */ /* ,cm.address_id    as address_key */ /* ,case when cm.comm_prnt_id > 0 then 'Компонент' else 'Элемент' end component_element_network_p */
  CASE WHEN "CM"."PRIZNAKDEL" > 0 THEN "CM"."DATEMODIF" END AS "EXP_DTTM", /* ok */ /* ,cm.prinadl_kod   as network_level_key */ /* ,cm.numbdec       as sn_num */ /* ,inPrefixSW||to_char(cm.markacomm_kod) as device_brand_key */
  "NT"."TYPNET_KOD" AS "NETWORK_TYPE_KEY", /* ,null             as issue_date */ /* ,null             as department_key */ /* ,null             as type_object_key */ /* ,null             as network_link_key */
  CAST('01.01.1900' AS DATE) AS "EFF_DTTM", /* ok */ /* ,null             as division_key */
  CASE WHEN "CM"."SOSTLOG_KOD" = 5 THEN "CM"."DATEMODIF" END AS "DEINSTALL_DT", /* ok */ /* ,cm.comm_id */ /* ,cm.markacomm_kod */ /* ,cm.street_kod */ /* ,cm.home */ /* ,cm.korp */ /* ,td.ISACTIVE */
  CASE WHEN "TD"."ISACTIVE" > 0 THEN COALESCE("TEH"."TECH_KOD", '-1') ELSE '-1' END AS "TECHNOLOGY_TYPE_KEY",
  "Z"."FILIAL_KOD" AS "BRANCH_KEY"
/* ,z.infouzel_kod   as uzel_id */ /* ,z.infouzel_sname as uzel_name */
FROM "EDW_ODS"."T_EDWV_ETH_COMM_ATU" AS "CM"
LEFT JOIN "EDW_ODS"."T_EDWV_ETH_MARKACOMM" AS "MR"
  ON "MR"."MARKACOMM_KOD" = "CM"."MARKACOMM_KOD"
LEFT JOIN "EDW_ODS"."T_EDWV_ETH_NET_ATU" AS "NT"
  ON "NT"."NET_ID" = "CM"."NET_ID"
LEFT JOIN "EDW_ODS"."T_EDWV_STORE_DEVICE_PARAM" AS "PR"
  ON "PR"."COMM_ID" = "CM"."COMM_ID"
LEFT JOIN "EDW_ODS"."T_EDWV_RH_ATU" AS "RH"
  ON "CM"."ADROBJECT_TYPE" = 2 AND "RH"."RH_ID" = "CM"."ADROBJECT_ID"
LEFT JOIN "EDW_ODS"."T_EDWV_GIS_SN" AS "SN"
  ON "SN"."ID_OBJ" = "CM"."COMM_ID" AND "SN"."ID_TYP" = 20
LEFT JOIN "T_TEHNOLOGY" AS "TEH"
  ON "TEH"."COMM_ID" = "CM"."COMM_ID"
LEFT JOIN "EDW_ODS"."T_EDWV_INFOUZEL" AS "Z"
  ON "Z"."INFOUZEL_KOD" = "CM"."UZEL"
LEFT JOIN "EDW_ODS"."T_EDWV_ETH_TYPDEV_COMM" AS "TD"
  ON "TD"."TYPDEVICE_KOD" = "MR"."TYPDEVICE_KOD"
LEFT JOIN "EDW_ODS"."T_EDWV_ETH_VENDOR" AS "VN"
  ON "VN"."VENDOR_ID" = "MR"."VENDOR_ID"
WHERE
  "CM"."SRC_CODE" <= 64
  AND "CM"."SRC_CODE" >= 32
  AND "PR"."STORE_DEVICE_PARAM_ID" IS NULL
  AND "Z"."INFOUZEL_TYPE_KOD" <> 1