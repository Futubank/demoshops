##--system info: module_owner="" module="" system="1"--##
%%include_template "_shared/code/skins/ami_touch/templates/_form.tpl"%%
%%include_language "_shared/code/skins/ami_touch/templates/lang/eshop_order_form.lng"%%

<!--#set var="order_details" value="
<div class="form-group input__##name## field__##name## eshop-order-page">
    <div class="col-md-12">
        <table width="100%">
            <div class="eshop-order-page__title-table">%%order_details%%</div>
           <td colspan=2 class="td_small_text">
            <table class="eshop-order-page__details" border=0 cellspacing=0 cellpadding=0 width="100%">
            <tr class="eshop-order-page__list-header">
              <td class="first_row_all" style="text-align: right;">N</td>
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
        </table>
    </div>
</div>
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
            <div title="##order_name## ##order_property_caption##">##order_name_short##</div>
            ##if(order_property_caption_short)##<div class="eshop-order-page__details-prop">##order_property_caption_short##</div>##endif##
        </div>
      </td>
      ##if(show_image_in_order_details)##
      <td class="##style##">
          ##if(ext_popup_picture != NULL)##
          <a href="javascript:;" onclick="new UI.Popup('<img src=\'##ext_popup_picture##\' style=\'max-width:400px;\'>', {id: 'imgPopup', width: 420, autoshow: true, modal: false, header: '##order_name## ##order_property_caption##'});">
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
      <td class="##style## eshop-order-page-list__total-price" align=center>&nbsp;##total##</td>
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
<div class="form-group eshop-order__history">
    <div class="col-md-12">
          <div class="history-blocks eshop-order-page__total-info">
              <div class="eshop-order-page__title-table eshop-order-page__total-list-title">%%total_order%%:</div>
              <div class="eshop-order-page__total-list">
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-price"><div>%%caption_goods_value%%</div><span id="total__caption_goods_value"></span></div>
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-shipping"><div>%%price_shipping%%</div><span id="total__price_shipping"></span></div>
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-discount"><div>%%title_discount%%</div><span id="total__title_discount"></span></div>
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-count"><div>%%order_number_items%%</div><span id="total__number_items"></span></div>
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-weight"><div>%%order_total_weight%%</div><span id="total__order_total_weight"></span></div>
                <div class="eshop-order-page__total-list-el eshop-order-page__total-list-total-price"><div class="eshop-order-page__total-list-amount-title">%%total_caption_amount%%</div><span id="total__total_caption_amount" class="eshop-order-page__total-list-amount"></span></div>
              </div>
              <script>
              $(document).ready(function () {
                $('#total__caption_goods_value').text($('#info-value__caption_goods_value').text());
                $('#total__price_shipping').text($('#info-value__shipping').text());
                $('#total__title_discount').text($('#info-value__applied_discount').text());
                $('#total__number_items').text($('#info-value__order_total_qty').text());
                $('#total__order_total_weight').text($('#info-value__order_total_weight').text());
                $('#total__total_caption_amount').text($('#info-value__amount').text());
              });
              </script>
          </div>
        <div class="history-blocks">
            <div class="eshop-order-page__title-table eshop-order-page__statuses-history">%%statuses_history%%</div>
              <table class="eshop-order-page__history" border=0 cellspacing=0 cellpadding=0>
              <tr class="eshop-order-page__list-header">
                <td class="first_row_left_td">%%date%%</td>
                <td class="first_row_all">%%status%%</td>
                <td class="first_row_all">%%changed_by%%</td>
                <td class="first_row_all">%%ip%%</td>
                <td class="first_row_all">%%just_comments%%</td>
              </tr>
              ##status_list##
              </table>
          </div>
    </div>
</div>
"-->

<!--#set var="select_field" value="
<div class="form-group selectbox field__##name## eshop-order-page">
    <label class="col-md-3 control-label" for="##name##">##element_caption##</label>
    <div class="col-md-3">
        <select ng-model="fields.##name##" id="##name##" name="##name##" class="select-chosen form-control form-style-input" data-placeholder="" ami_validators="##validators##">
            ##-- <option></option> FOR CHOSEN PLUGIN --##
            ##select##
        </select>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="textarea_field" value="
<div class="form-group textarea-input textarea__##name## field__##name## eshop-order-page">
    <label for="html_title" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8">
        <div class="textarea-block">
            <textarea ng-model="fields.##name##" id="##name##" name="##name##" rows="##if((name=="html_keywords")||(name=="html_description"))##3##else##6##endif##" class="form-control textarea-editor textarea-input" ##IF(validator_filled)##required##endif## ami_validators="##validators##"></textarea>
            <i title="%%delete_content%%" onclick="clearArea('##name##', this);return false;" class="fa fa-times close-btn"></i>
        </div>
        <div class="has-error" ng-show="ami_form.##name##.$dirty && ami_form.##name##.$invalid">
            <div id="error_msg_##name##" for="##name##" class="help-block animation-slideDown"></div>
        </div>
    </div>
</div>
"-->

<!--#set var="static_field(name=login_static)" value=""-->

<!--#set var="static_field(name=id_static)" value="
<div class="form-group input__##name## field__##name## eshop-order-page">
    <label for="##name##" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8"><b>##value##</b></div>
</div>
"-->

<!--#set var="static_field(name=status_changed)" value="
<div class="form-group input__##name## field__##name## eshop-order-page">
    <label for="##name##" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8"><small>##value##</small></div>
</div>
"-->

<!--#set var="static_field" value="
<div class="form-group input__##name## field__##name## eshop-order-page">
    <label for="##name##" class="col-md-3 control-label">##element_caption##</label>
    <div class="col-md-8">##value##</div>
</div>
"-->

<!--#set var="comlex_info_row" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span id="info-value__##name##" class="eshop-order-page__info-value">##value##</span>
</div>
"-->

<!--#set var="comlex_info_row(name="form_field_tracking_number")" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span class="eshop-order-page__info-value">##IF(url)##<a href="##value##" target="_blank">##value##</a>##ELSE####value####ENDIF##</span>
</div>
"-->

<!--#set var="comlex_info_row(name="person_type")" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span class="eshop-order-page__info-value"><b>##value##</b></span>
</div>
"-->

<!--#set var="comlex_info_row(name="login")" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span class="eshop-order-page__info-value">##value##</span>
</div>
"-->

<!--#set var="comlex_info_row(name="email")" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span class="eshop-order-page__info-value"><a href="mailto:##email_encoded##" target="_top">##value##</a></span>
</div>
"-->

<!--#set var="comlex_info_row(name="amount")" value="
<div class="eshop-order__complex-info">
    <span class="eshop-order-page__info-title">##caption##: </span>
    <span id="info-value__##name##" class="eshop-order-page__info-value"><b>##value##</b></span>
</div>
"-->


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

<!--#set var="section_notify" value="
<div class="form-group eshop-order__section-notify eshop-order-page">
    <label class="col-md-3 control-label">%%send_notification%%</label>
    <div class="col-md-8">
        <table>
        <tr>
            <td align=left colspan=2 style="padding-top: 15px;">
                <label><input name="send_notification" type="radio" value="force">%%force_send%%</label><br>
                <label><input name="send_notification" type="radio" value="dont">%%dont_send%%</label><br>
                <label><input name="send_notification" type="radio" value="default" checked="checked">%%default%%</label>
            </td>
        </tr>
        </table>
    </div>
</div>
"-->