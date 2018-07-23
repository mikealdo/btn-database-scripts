select art.*
 ,btn_art_st.id btn_art_st_id
 ,btn_art_st.art_status as art_status
 ,btn_art_st.art_status_depot as art_status_depot
 ,btn_art_st.art_note as art_note
 ,btn_art_st.dms_del
 ,btn_art_st.art_place
 ,btn_art_st.art_place_depot
 ,btn_art_st.dms30
 ,btn_art_st.art_qty
 ,btn_art_st.mut_art_qty
 ,btn_art_st.depot_art_qty
 ,btn_art_st.depot_mut_art_qty
 ,btn_art_st.order_store
 ,btn_art_st.order_store_date
 ,btn_art_st.order_depot
 ,btn_art_st.order_depot_date
 ,btn_art_st.stock_ordered
 ,btn_art_st.stock_reserved
 ,btn_art_st.stock_na
 ,btn_art_st.sell_price
 ,btn_art_st.catalog_list
 ,btn_art_st.block_ind
 ,btn_art_st.orderable
 ,btn_art_st.mmail_no
 ,btn_art_st.mmail_type
 ,btn_art_st.active active_store
 ,btn_art_st.manual_block manual_block_store
from (
select art.*
from (
select art.*, rownum rownum_
from (
select
 btn_art.id
 ,btn_art.art_no
 ,btn_art.leading_no
 ,btn_art.marketing_name_cz
 ,btn_art.marketing_name_en
 ,btn_art.marketing_name_sk
 ,btn_art.marketing_name_vi
 ,btn_art.vat
 ,btn_art.reduced_vat
 ,btn_art.reduced_vat_ind
 ,btn_art.art_unit
 ,btn_art.art_weight
 ,case when btn_art.art_weight_mean = 0 then 1 else btn_art.art_weight_mean end art_weight_mean
 ,btn_art.art_weight_min
 ,btn_art.art_weight_max
 ,btn_art.art_weight_big
 ,btn_art.art_type_2
 ,btn_art.dpt_no dept_no
 ,btn_art.grp_type
 ,btn_art.extra_type
 ,btn_art.descr
 ,btn_art.aro_article_new
 ,btn_art.cont_sell_unit
 ,btn_art.std_factor
 ,btn_art.expiry_days
 ,btn_art.art_grp_sub_no
 ,btn_art.art_no_deposit
 ,btn_art.suppl_no
 ,btn_art.mutation_art_no
 ,btn_art.mutation_descr
 ,btn_art.mutation_stock_koef
 ,btn_art.grp_no art_grp_no
 ,btn_art.grp_descr as grp_descr
 ,btn_art.supl_name
 ,btn_art.own_brand_descr
 ,btn_art.barcode
 ,btn_art.active
 ,btn_art.price_1
 ,btn_art.price_2
 ,btn_art.art_weight_pack
 ,btn_art.dummy
 ,btn_art.cfa_type
 ,btn_art.manual_block
 ,btn_art.xx
 ,btn_art.xy
 ,btn_art.art_volume
 ,btn_art.waste_type_no
 ,btn_art.waste_grp_no
 ,btn_art.waste_tax_amnt
from btn_article btn_art
 ,btn_article_store btn_art_st
where btn_art.id = btn_art_st.btn_article_id
  and btn_art_st.store_no = 6
  and ((translate(btn_art.search_text2, 'ÁÄČĎÉĚËÍŇÓÖÔŘŠŤÚŮÜÝŽĽĹŔ', 'AACDEEEINOOORSTUUUYZLLR') like '%'||translate('KKK', 'ÁÄČĎÉĚËÍŇÓÖÔŘŠŤÚŮÜÝŽĽĹŔ', 'AACDEEEINOOORSTUUUYZLLR')||'%'))
  and btn_art_st.orderable = 'A'
  and btn_art.active = 'A'
order by btn_art.dpt_no, btn_art.grp_no, btn_art.descr

) art
where rownum < 50) art
where art.rownum_ >= 1
) art ,btn_article_store btn_art_st
where art.id = btn_art_st.btn_article_id
  and btn_art_st.store_no = 6;
