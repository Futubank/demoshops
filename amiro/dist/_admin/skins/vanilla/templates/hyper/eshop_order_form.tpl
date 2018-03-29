##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/hyper/eshop_order_form.lng"%%
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="tab" value="
<div class="tab-page eshop-order-page" id="tab-page-##name##">
<table class="frm" cellspacing="5" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="static_field(name=sep_customer_info)" value="
<tr>
    <td class="eshop-order-page__edit-order"><b>##element_caption##</b>:</td>
    <td></td>
</tr>
"-->

<!--#set var="static_field(name=sep_delivery)" value="
<tr>
    <td class="eshop-order-page__edit-order"><div class="eshop-order-page__tr-splitter"></div><b>##element_caption##</b>:</td>
    <td></td>
</tr>
"-->

<!--#set var="static_field" value="
<tr>
    <td>##element_caption##:</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="static_field(name=name_static)" value="
<tr class="eshop-order-page__el-##name##">
    <td>##element_caption##:</td>
    <td><span>##value##</span></td>
</tr>
"-->

<!--#set var="static_field(name=login_static )" value=""-->

<!--#set var="static_field(name=id_static)" value="
<tr>
    <td class="eshop-order-page__width-col-first">##element_caption##:</td>
    <td class="eshop-order-page__width-col-two"><b>##value##</b></td>
</tr>
"-->

<!--#set var="static_field(name=status_changed)" value="
<tr style="height: 20px;">
    <td>&nbsp;</td>
    <td class="eshop-order-page__status-changed"><small>%%status_changed%% ##value##</small></td>
</tr>
"-->

<!--#set var="static_field(caption=payment_method)" value="
<tr>
    <td>##element_caption##:</td>
    <td>##value##</td>
</tr>
<tr><td colspan="2"><hr /></td></tr>
"-->

<!--#set var="static_field(caption=amount)" value="
<tr>
    <td><b>##element_caption##:</b></td>
    <td><b>##value##</b></td>
</tr>
"-->

<!--#set var="static_field(caption=customer_info)" value="
<tr>
    <td valign="top"><b>##element_caption##</b>:</td>
    <td>
        <table cellspacing="0" class="eshop-order-page__user-info customer-info__##name##">
        ##value##
        </table>
    </td>
</tr>
"-->

<!--#set var="static_field(caption=delivery_info)" value="
<tr>
    <td valign="top"><b>##element_caption##</b>:</td>
    <td>
        <table cellspacing="0" class="eshop-order-page__user-info customer-info__##name##">
        ##value##
        </table>
    </td>
</tr>
"-->

<!--#set var="static_field(caption=payment_info)" value="
<tr>
    <td valign="top"><b>##element_caption##</b>:</td>
    <td>
        <table cellspacing="0" class="eshop-order-page__user-info customer-info__##name##">
        ##value##
        </table>
    </td>
</tr>
"-->

<!--#set var="comlex_info_row" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td id="info-value__##name##" class="eshop-order-page__info-value">##value##</td>
</tr>
"-->

<!--#set var="comlex_info_row(name="form_field_tracking_number")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td class="eshop-order-page__info-value">##IF(url)##<a href="##value##" target="_blank">##value##</a>##ELSE####value####ENDIF##</td>
</tr>
"-->

<!--#set var="comlex_info_row(name="person_type")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td class="eshop-order-page__info-value"><b>##value##</b></td>
</tr>
"-->

<!--#set var="comlex_info_row(name="login")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td class="eshop-order-page__info-value eshop-order-page__info-value-user"><a href="##members_adm_link##id=##id_user##&action=edit" target="_blank">##value##</a></td>
</tr>
"-->

<!--#set var="comlex_info_row(name="email")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td class="eshop-order-page__info-value"><a href="mailto:##email_encoded##" target="_top">##value##</a></td>
</tr>
"-->

<!--#set var="comlex_info_row(name="comments")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##:</td>
    <td class="eshop-order-page__info-value">##value##</td>
</tr>
"-->

<!--#set var="comlex_info_row(name="amount")" value="
<tr>
    <td class="eshop-order-page__info-title">##caption##: </td>
    <td id="info-value__##name##" class="eshop-order-page__info-value"><b>##value##</b></td>
</tr>
"-->

<!--#set var="textarea_field(caption=adm_comments)" value="
<tr>
    <td valign="top"><b>##element_caption##</b>##IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF## eshop-order-page__comments" wrap="soft" cols="##cols##" style="width:230px"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
    </td>
</tr>
"-->

<!--#set var="static_field(caption=comments_static)" value="
<tr>
    <td><b>##element_caption##</b>:</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="textarea_field(caption=comments)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="soft" cols="##cols##" style="width:230px"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
    </td>
</tr>
"-->

<!--#set var="order_details" value="
     <tr><td colspan="2"><b>%%order_details%%</b>:</td></tr>
     <tr>
       <td colspan=2 class="td_small_text">
        <table class="eshop-order-page__details" border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr>
          <td class="first_row_all" style="text-align: right;">№</td>
          <td class="first_row_all">%%product%%</td>
          ##if(show_image_in_order_details)##
            <td class="first_row_all" align=center>%%ext_img%%</td>
          ##endif##
          <td class="first_row_all" align=center>%%curr_price%%</td>
          <td class="first_row_all" align=center>%%purchase_price%%</td>
          <td class="first_row_all" align=center>%%quantity%%</td>
          <td class="first_row_all" align=center>%%total%%</td>
##if(ENABLE_WEIGHT_COL)##
          <td class="first_row_all" align=center>%%weight%%</td>
          <td class="first_row_all" align=center>%%total_weight%%</td>
##endif##
##if(ENABLE_SIZE_COL)##
          <td class="first_row_all" align=center>%%size%%</td>
##endif##
##if(shipping_conflicts == "show_shipping_for_each_type")##
          <td class="first_row_all" align=center>%%shipping_method%%</td>
##endif##

          ##eshop_digitals_header##
        </tr>
        ##product_list##
        </table>

        <table>
        <tr><td valign="top">
        <td valign="top" align="left">
        ##eshop_digitals_legend##
        </td>
        </tr></table>
    </td>
</tr>
"-->

<!--#set var="price_caption" value="
<br>(##price_caption##)
"-->

<!--#set var="item_row" value="
    <tr>
      <td class="##style##" style="text-align: right;">##number##</td>
      <td class="##style##" >
        <div class="eshop-order-page__details-item">
            <div class="eshop-order-page__details-sku">%%code%%: ##sku####IF(purchase_sku!="")##(##purchase_sku##)##endif##</div>
            <a title="##order_name## ##order_property_caption##" href="##product_url##" target="_blank">##order_name_short##</a>
            ##if(order_property_caption_short)##<div class="eshop-order-page__details-prop">##order_property_caption_short##</div>##endif##
        </div>
      </td>
      ##if(show_image_in_order_details)##
      <td class="##style##">
          ##if(ext_popup_picture != NULL)##
          <a href="javascript:;" onclick="new AMI.UI.Popup('<img src=\'##ext_popup_picture##\' style=\'max-width:400px;\'>', {id: 'imgPopup', width: 420, autoshow: true, modal: false, header: '##order_name## ##order_property_caption##'});">
          <img src="##ext_small_picture##" class="eshop-order-page__details-image" />
          </a>
          ##else##
          %%ext_img_not_found%%
          ##endif##
      </td>
      ##endif##
      <td class="##style##" align=center>&nbsp;##curr_price##</td>
      <td class="##style##" align=center>&nbsp;##purchase_price####price_caption##</td>
      <td class="##style##" align=center>&nbsp;##qty##</td>
      <td class="##style##" align=center>&nbsp;##total##</td>
##if(ENABLE_WEIGHT_COL)##
      <td class="##style##" align=center>&nbsp;##weight##</td>
      <td class="##style##" align=center>&nbsp;##total_weight##</td>
##endif##
##if(ENABLE_SIZE_COL)##
      <td class="##style##" align=center>&nbsp;##size##</td>
##endif##
##if(shipping_conflicts == "show_shipping_for_each_type")##
      <td class="##style##">##shipping_method_name##&nbsp;</td>
##endif##

      ##eshop_digitals_col##
    </tr>
"-->

<!--#set var="eshop_digitals_expire" value="
     <tr>
       <td>
        %%expire_date%%:
       </td>
       <td>
         <input type=text name="expire_date" class='field fieldDate' value="##eshop_digitals_expire##" maxlength="30" helpId= "form_date" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.eshop_form.expire_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
       </td>
     </tr>
"-->

<!--#set var="eshop_digitals_header" value="
<td class="first_row_all" align=center>%%eshop_digitals_attempts%%</td>
"-->

<!--#set var="eshop_digitals_row" value="
<tr>
  <td>
    <span title="##filename##"><font color="##name_color##">##short_filename##</font></span>&nbsp;
  </td>
  <td align="right">
    <input type=text name="number_attempts##file_id##" value="##number_attempts##" class="field field2" style="width: 60px; background: #eee;" maxlength="3" ##atempts_disabled## readonly="readonly" />
    <input type=hidden name="file_id##id##[]" value="##file_id##" />
    <input type=hidden name="number_attempts_old##file_id##" value="##number_attempts##" />
  </td>
  <td width="50">&nbsp;%%is_of%%&nbsp;##number_initial_attempts##
  </td>
</tr>
"-->

<!--#set var="eshop_digitals_col" value="
<td class="##style##" align=right>
<table cellspacing="0" cellpadding="0" width=100% border="0">
  ##eshop_digitals_rows##
</table>
<input type=hidden name="id##index##" value="##id##">
</td>
"-->

<!--#set var="item_row_ownername_header" value="
<td class="first_row_all" align=right>%%order_owner%%</td>
"-->

<!--#set var="item_row_ownername" value="
<td class="##style##" align=right>##owner_name##</td>
"-->

<!--#set var="eshop_digitals_col_na" value="
<td class="##style##" align=right>%%not_available%%</td>
"-->

<!--#set var="item_row_newname" value="
<br>(<span title="##name##">##name_short##</span>)
"-->

<!--#set var="history" value="
     <tr>
       <td colspan=2 valign="top" class="td_small_text">
            <table width="100%" border=0 cellspacing=0 cellpadding=0>
                <tr>
                <td valign="top">
                    <div class="eshop-order-page__title-table">%%statuses_history%%:</div>
                  <table class="eshop-order-page__history" border=0 cellspacing=0 cellpadding=0>
                  <tr>
                    <td class="first_row_left_td">%%date%%</td>
                    <td class="first_row_all">%%status%%</td>
                    <td class="first_row_all">%%changed_by%%</td>
                    <td class="first_row_all">%%ip%%</td>
                    <td class="first_row_all">%%just_comments%%</td>
                  </tr>
                  ##status_list##
                  </table>
              </td>
                <td valign="top" class="eshop-order-page__total-info">
                  <div class="eshop-order-page__title-table eshop-order-page__total-list-title">%%total_order%%:</div>
                  <div class="eshop-order-page__total-list">
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-price"><div>%%caption_goods_value%%</div><span id="total__caption_goods_value"></span></div>
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-shipping"><div>%%price_shipping%%</div><span id="total__price_shipping"></span></div>
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-discount"><div>%%title_discount%%</div><span id="total__title_discount"></span></div>
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-count"><div>%%order_number_items%%</div><span id="total__number_items"></span></div>
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-weight"><div>%%order_total_weight%%</div><span id="total__order_total_weight"></span></div>
                    <div class="eshop-order-page__total-list-el eshop-order-page__total-list-total-price"><div class="eshop-order-page__total-list-amount-title">%%total_caption_amount%%</div><span id="total__total_caption_amount" class="eshop-order-page__total-list-amount"></span></div>
                                  </div>
                  </td>
              </tr>
          </table>
       </td>
     </tr>
"-->

<!--#set var="static_field(caption=base_currency)" value="<tr>
    <td>##element_caption##:</td>
    <td>##value##
       <input type="hidden" name='aaaaa123' id="order_base_currency" value="##value##" />
    </td>
</tr>"-->

<!--#set var="status_row" value="
    <tr>
      <td class="##style##">##date##&nbsp;</td>
      <td class="##style##">##status##&nbsp;</td>
      <td class="##style##">##changed_by##&nbsp;</td>
      <td class="##style##">##ip##&nbsp;</td>
      <td class="##style##">##comments##&nbsp;</td>
    </tr>
"-->

<!--#set var="section_buyer_info" value="<tr>
    <td valign="top">%%buyer_info%%:</td>
    <td>
        <table id="id_buyer_info" border="0" cellspacing="0" cellpadding="0">
        ##section_html##
        </table>
    </td>
</tr>"-->

<!--#set var="section_refresh_currency" value="##-- <tr>
        <td width="300">%%refresh_currency_title%%:</td>
        <td><input type="checkbox" name="refresh_currency" /></td>
    </tr> --##
    ##section_html##"-->

<!--#set var="products_edit_table" value="
     <tr>
        <td>%%order_shipping%%</td><td><input name="order_shipping" id="order_shipping" value="##shipping##" style="width:70px;text-align:right;" class="field" /><span>&nbsp;##item_currency##</span></td>
     </tr>
      <tr>
        <td colspan="2"><div class="eshop-order-page__tr-splitter"></div><b>%%order_value%%</b></td>
     </tr>
     <tr>
        <td>%%order_subtotal%%</td><td><input name="order_subtotal" id="order_subtotal" value="0" style="width:70px;text-align:right;background:#EEEEEE;" class="field" readonly="readonly" /><span>&nbsp;##item_currency##</span></td>
     </tr>
     <tr>
        <td>%%tax_total%%</td><td><input name="tax_total" id="tax_total" value="0" style="width:70px;text-align:right;background:#EEEEEE;" class="field" readonly="readonly" /><span>&nbsp;##item_currency##</span></td>
     </tr>
     <tr>
        <td>%%order_total%%</td><td><input id="order_total" name="order_total" style="width:70px;text-align:right;background:#EEEEEE;" class="field"  readonly="readonly" value="0"/><span>&nbsp;##item_currency##</span></td>
     </tr>
     <tr>
        <td>%%caption_base_currency%%</td>
        <td>##order_base_currency##</td>
     </tr>
     <tr>
       <td colspan="2" style="padding-top:16px;">
            <b>%%products_edit_table_title%%</b>:
                   <div class="icon_button_add" style="float: right;">
                                <a href="#" onclick="AMI.Message.send('ON_ORDER_EDIT_ADD_ITEM', 'select', {}); return false;">
                                        <span class="text_button">%%add_item_row%%</span>
                                        <span id="show_image_in_order_details" style="display: none;">##show_image_in_order_details##</span>
                                        <img class="icon" src="skins/vanilla/icons/icon-popup_add.gif" align="absmiddle">
                                </a>
                        </div>
       </td>
     </tr>
     <tr>
       <td colspan=2 class="td_small_text">
          <style>
            #products_edit_table input {text-align:right;}
            #products_edit_table td {padding-left:4px;padding-right:4px;}
          </style>
          <table border=0 cellspacing=1 cellpadding=1 width=100% id="products_edit_table">
          <tr>
            <td class="first_row_left_td">%%odl_id%%</td>
            <td class="first_row_all">%%odl_name%%</td>
            <td class="first_row_all">%%odl_qty%%</td>
##--            <td class="first_row_all">%%odl_code%%</td>  --##
            <td class="first_row_all">%%odl_discounts%%</td>
            <td class="first_row_all">%%odl_taxes%%</td>
            <td class="first_row_all">%%odl_prices%%</td>
            <td class="first_row_all">%%odl_actions%%</td>
          </tr>
          ##products_edit_list##
          </table>
       </td>
     </tr>
     <tr>
        <td colspan="2"><div class="eshop-order-page__tr-splitter"></div></td>
     </tr>
     <tr>
        <td colspan="2" style="font-size:10px;background-color:#FFFFE1;border:1px #666666 solid; padding:5px;">%%form_hint%%</td>
     </tr>
     <tr>
        <td colspan="2"><div class="eshop-order-page__tr-splitter"></div></td>
     </tr>
"-->

<!--#set var="products_edit_table_row" value="<tr class="productsEditTableRow">
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;"><span>##item_id##</span><input type="hidden" name="items_order_item_id[##item_index##]" value="##order_item_id##" /><input type="hidden" name="items_item_id[##item_index##]" value="##item_id##" /></td>
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;">
<div style="min-width:150px;">
      <span>##item_name## ##item_props_caption##</span><input type="hidden" name="items_name[##item_index##]" value="##item_name##" /><input type="hidden" name="items_props_caption[##item_index##]" value="##item_props_caption##" /><br />
      <span>%%odl_code%%: ##item_sku##</span><input name="items_sku[##item_index##]" value="##item_sku##" type="hidden" />
      <br />
      <div class="image_order_details">
      ##if(show_image_in_order_details)##
          ##if(ext_popup_picture != NULL)##
              <a href="javascript:;" onclick="new AMI.UI.Popup('<img src=\'##ext_popup_picture##\' style=\'max-width:400px;\'>', {id: 'imgPopup', width: 420, autoshow: true, modal: false, header: '##item_name##'});">
              <img src="##ext_small_picture##" style="max-width: 200px;" />
              </a>
          ##endif##
      ##endif##
      </div>
</div>
    </td>
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;"><input name="items_qty[##item_index##]" value="##item_qty##" style="width:70px;" class="field" /></td>
##--    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;"><input name="items_sku[##item_index##]" value="##item_sku##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" /></td> --##
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;">

        <table border=0 cellspacing=0 cellpadding=0>
            <tr><td align="right"><input name="items_prc_discount[##item_index##]" value="##item_prc_discount##" style="width:70px;" class="field" /></td><td>&nbsp;%</td></tr>
            <tr><td align="right"><input name="items_abs_discount[##item_index##]" value="##item_abs_discount##" style="width:70px;" class="field" /></td><td><span>&nbsp;##item_currency##</span></td></tr>
            <tr><td colspan="2"><span>(%%absolute_discount_cmt%%)</span>&nbsp;&nbsp;&nbsp;</td></tr>
        </table>

    </td>
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;">

        <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>%%tax%%:</td><td><input name="items_tax[##item_index##]" value="##item_tax_item_value##" style="width:70px;" class="field" /></td></tr>
            <tr><td>%%tax_type%%:</td><td>
                <select name="items_tax_type[##item_index##]" style="width:70px;" class="field">
                    <option value="percent" ##if(item_tax_type == "percent")##selected="selected"##endif##>%%percent%%</option>
                    <option value="abs" ##if(item_tax_type == "abs")##selected="selected"##endif##>%%abs%%</option>
                </select>
            </td></tr>
            <tr><td>%%charge_tax_type%%:</td><td>
                <select name="items_charge_tax_type[##item_index##]" style="width:70px;" class="field">
                    <option value="charge" ##if(item_charge_tax_type == "charge")##selected="selected"##endif##>%%charge%%</option>
                    <option value="detach" ##if(item_charge_tax_type == "detach")##selected="selected"##endif##>%%detach%%</option>
                </select>
            </td></tr>
            <tr><td>%%tax_item%%:</td><td><span style="white-space:nowrap;"><input name="items_tax_item[##item_index##]" value="##item_tax_item##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%tax_total%%:</td><td><span style="white-space:nowrap;"><input name="items_tax_total[##item_index##]" value="##item_tax##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
        </table>

    </td>
    <td valign="top" style="border-bottom: 1px dashed #aaaaaa;">

        <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>%%odl_original_price%%:</td><td><span style="white-space:nowrap;"><input name="items_original_price[##item_index##]" value="##item_original_price##" style="width:70px;" class="field" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%odl_price%%:</td><td><span style="white-space:nowrap;"><input name="items_price[##item_index##]" value="##item_price##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%odl_current_price%%:</td><td><span style="white-space:nowrap;"><input name="items_current_price[##item_index##]" value="##item_cur_price##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%odl_tax_price%%:</td><td><span style="white-space:nowrap;"><input name="items_tax_price[##item_index##]" value="##item_cur_price_tax##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%odl_order_price%%:</td><td><span style="white-space:nowrap;"><input name="items_order_price[##item_index##]" value="##item_order_price##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" />&nbsp;##item_currency##</span></td></tr>
            <tr><td>%%odl_price_number%%:</td><td><input name="items_price_number[##item_index##]" value="##item_price_number##" style="width:70px; background:#EEEEEE;" class="field" readonly="readonly" /></td></tr>
        </table>

    </td>
        <td style="border-bottom: 1px dashed #aaaaaa;" align=middle>
                <a href="javascript:;" onclick="if(confirm('%%confirm_delete%%')){AMI.Message.send('ON_ORDER_EDIT_DELETE_ITEM', 'delete', {target:this});} if(event && AMI.Browser.isIE){event.returnValue = false;} return false;" class="list-icon icon-delete"><div class="eshop_order_delete"></div></a>
        </td>
</tr>"-->

<!--#set var="section_notify" value="
<tr>
    <td class="eshop-order-page__sent-note">%%send_notification%%: &nbsp;</td>
    <td>
            <label><input name="send_notification" type="radio" value="force">%%force_send%%</label><br>
            <label><input name="send_notification" type="radio" value="dont">%%dont_send%%</label><br>
            <label><input name="send_notification" type="radio" value="default" checked="checked">%%default%%</label>
    </td>
</tr>
"-->

<!--#set var="order_change_table" value="
##if(!changed)##
     <tr>
       <td colspan="2" style="padding-top:16px">
         %%order_change_table_title%%: %%not_changed%%
       </td>
     </tr>
##else##
     <tr>
       <td colspan=2 class="td_small_text" style="padding-top:20px;">
          <table border=0 cellspacing=1 cellpadding=1 width=100%>
          <tr>
            <td class="first_row_left_td" colspan="2">&nbsp;&nbsp;%%order_change_table_title%%</td>
          </tr>
          </table>
          <div style="width:100%;max-height:300px;overflow:auto;">
          <table border=0 cellspacing=1 cellpadding=1 width=100%>
          ##order_change_list##
          </table>
          </div>
       </td>
     </tr>
##endif##
"-->

<!--#set var="order_change_row" value="
<tr>
    <td valign="top" width="130" style="padding-top:6px;"><span>
        ##date##<br /><br />
        ##ip##<br />
        ##author##
</span>
    </td>
    <td valign="top">##changes##</td>
</tr>
<tr>
    <td colspan="5" style="border-bottom:1px dashed #cccccc;"></td>
</tr>
"-->

<!--#set var="order_changes_row" value="
<tr>
    <td align="right">##name##:</td>
    <td width="150" align="right">##old_value##</td>
    <td width="150" align="right">##new_value##</td>
</tr>
"-->

<!--#set var="order_changes" value="
<table width="100%" cellpadding="3" style="padding-bottom:12px;">
<tr style="background-color:#EEEEEE;">
    <td style="padding:6px;">##title##</td>
    <td style="font-weight:bold;padding:6px;">%%changes_param_prev%%</td>
    <td style="font-weight:bold;padding:6px;">%%changes_param_new%%</td>
</tr>
##rows##
</table>
"-->

<!--#set var="changes_title" value="<b>##action##</b>##if(name)##: ##name####endif##"-->

<!--#set var="form_buttons" value="<div id="form-buttons">
        <div class="eshop-order-page__top-print" onclick="AMI.Page.doModuleAction('eshop_order', AMI.Page.aModules['eshop_order'].getComponentsByType('list')[0], 'list_print', {id:AMI.Page.getHashData('eshop_order').id}); return false;"></div>
    <div style="float:left;">
        <input type="button" name="print" value="  %%print_order%%  " class="but-mid" onclick="AMI.Page.doModuleAction('eshop_order', AMI.Page.aModules['eshop_order'].getComponentsByType('list')[0], 'list_print', {id:AMI.Page.getHashData('eshop_order').id}); return false;" >
    </div>
    ##cancel_btn## ##add_btn## ##save_btn## ##apply_btn##
</div>"-->

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;

function invalidQty(oInput){
    oInput.focus();
    alert('%%invalid_qty%%');
}

function emptyOrderDenied(){
    alert('%%empty_order%%');
}
</script>

<div id="div_properties_form" class="main-form">
        <table ccc="1" class="properties_form_table" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;##IF(!ami_order_id)## display: none;##ENDIF##">
                <tr class="properties_form_title">
                        <td align=left id="add_left_top_img"></td>
                        <td nowrap id="add_center_top_img">
                                <span id="form_title" class="form-header">##header##</span>
                        </td>
                        <td nowrap id="add_right_info_top_img">
                                <div id=stModified style="display:none;" class=form-header> [ %%modified%% ]</div>
                        </td>
                        <td id="add_right_top_img"></td>
                </tr>
                <tr>
                        <td id="add_left_center_img"></td>
                        <td colspan=2 class="table_sticker" valign="top">
<br>
<form class="eshop-order-page__form" data-ami-component-id="##_component_id##" id="ami_form_##_component_id##" class="form" action="##action##" method="post" enctype="multipart/form-data" name="##_mod_id##form" onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_save', this); return false;">
<input type="hidden" name="action" value="" />
<input type="hidden" name="ami_full" value="" />
<input type="hidden" name="type" value="" />
##IF(!ami_order_id)##
<input type="hidden" name="id" value="" />
##ENDIF##
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
##section_html##
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
<td colspan="2" align="right">
<br>
##form_buttons##
<br><br>
</td>
</tr>
<tr>
<td colspan="2">
 <sub>%%required_fields%%</sub>
</td>
</tr>
</table>
</form>
                        </td>
                        <td id="add_right_center_img"></td>
                </tr>
                <tr>
                        <td id="add_left_bot_img"></td>
                        <td id="add_center_bot_img" colspan=2></td>
                        <td id="add_right_bot_img"></td>
                </tr>
        </table>
</div>
"-->
