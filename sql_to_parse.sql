select cm.comm_id as network_element_key    -- ok
                        ,coalesce (case when cm.comm_prnt_id   > 0 then cm.comm_prnt_id
                              when cm.adrobject_type = 1 then cm.adrobject_id
                              when cm.adrobject_type = 2 then cm.adrobject_id end,'-1') as network_parent_device_key -- ok
                        ,mr.typdevice_kod ::VARCHAR as network_element_type_key  -- ok
                        --,cm.invproj_id    as project_key
                        ,cm.datev         as install_dt  -- ok
                        ,case when cm.comm_prnt_id = 0 and rh.rh_id > 0 then rh.numb||' ' end|| cm.numb as network_element_name
                        ,coalesce(cm.sostlog_kod,'-1') as equipment_status_key  -- ok
                        --,sn.invn          as inventory_num
                        --,vn.vendor_name   as equipment_brand
                        --,cm.address_id    as address_key
                        --,case when cm.comm_prnt_id > 0 then 'Компонент' else 'Элемент' end component_element_network_p
                        ,case when cm.priznakdel   > 0 then cm.datemodif end as exp_dttm -- ok
                        --,cm.prinadl_kod   as network_level_key
                        --,cm.numbdec       as sn_num
                        --,inPrefixSW||to_char(cm.markacomm_kod) as device_brand_key
                        ,nt.typnet_kod    as network_type_key
                        --,null             as issue_date
                        --,null             as department_key
                        --,null             as type_object_key
                        --,null             as network_link_key
                        ,'01.01.1900' ::DATE     as eff_dttm -- ok
                        --,null             as division_key
                        ,case when cm.sostlog_kod = 5 then cm.datemodif end as deinstall_dt --ok
                        --,cm.comm_id
                        --,cm.markacomm_kod
                        --,cm.street_kod
                        --,cm.home
                        --,cm.korp
                        --,td.ISACTIVE
                        ,case when td.isactive>0 then coalesce(teh.tech_kod,'-1') else '-1' end as technology_type_key
                        ,z.filial_kod     as branch_key
                        --,z.infouzel_kod   as uzel_id
                        --,z.infouzel_sname as uzel_name
                    from edw_ods.t_EDWV_eth_comm_atu    cm
              left join edw_ods.t_EDWV_eth_net_atu     nt on nt.net_id        = cm.net_id
              left join edw_ods.t_EDWV_eth_markacomm   mr on mr.markacomm_kod = cm.markacomm_kod
              left join edw_ods.t_EDWV_eth_typdev_comm td on td.typdevice_kod = mr.typdevice_kod
              left join edw_ods.t_EDWV_eth_vendor      vn on vn.vendor_id     = mr.vendor_id
              left join edw_ods.t_EDWV_infouzel        z  on z.infouzel_kod   = cm.uzel
               left join edw_ods.t_EDWV_rh_atu          rh on rh.rh_id         = cm.adrobject_id and cm.adrobject_type = 2
               left join edw_ods.t_EDWV_gis_sn          sn on sn.id_obj        = cm.comm_id      and sn.id_typ         = 20
               left join edw_ods.t_EDWV_store_device_param pr on pr.comm_id = cm.comm_id
               left join t_tehnology teh on teh.comm_id=  cm.comm_id
                   where pr.store_device_param_id is null
                     and z.INFOUZEL_TYPE_KOD <> 1
                     and cm.src_code between 32 and 64
