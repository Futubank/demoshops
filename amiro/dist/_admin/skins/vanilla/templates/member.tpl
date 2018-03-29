%%include_language "templates/lang/member.lng"%%

<!--#set var="obligatory" value="<sup><strong>*</strong></sup>"-->

<!--#set var="header_script" value="
var member_changed = false;
"-->

<!--#set var="on_change_script" value="
  var target = amiCommon.getEventTarget(evt);
  switch(target.name) {
  case "username":
  case "email":
  case "firstname":
  case "lastname":
  case "address1":
  case "address2":
  case "city":
  case "state":
  case "zip":
  case "country":
  case "company":
  case "website":
    member_changed = true;
    break;
  default:
  }
"-->

<!--#set var="check_form_script" value="
//return true;

##if(check_obligatory_username=="1")##
   if(typeof(form.username) != 'undefined'){
       if (form.username.value.length<##username_minlength## || form.username.value.match(/[^a-zA-Z0-9_]+/)) {
           return focusedAlert(form.username, '%%username_warn1%% ##username_minlength##\n%%username_warn2%%');
       }
   }
##endif##
##if(check_obligatory_email=="1")##
   if (form.email.value=="") {
       return focusedAlert(form.email, '%%email_warn%%');
   } else if(isEmail(form.email.value) == false) {
       return focusedAlert(form.email, '%%email_invalid%%');
   }
##endif##
##if(check_obligatory_firstname=="1")##
   if(form.firstname.value.length<1) {
      return focusedAlert(form.firstname, '%%fname_warn%%');
   }
##endif##
##if(check_obligatory_lastname=="1")##
   if(form.lastname.value.length<1) {
      return focusedAlert(form.lastname, '%%lname_warn%%');
   }
##endif##
##if(check_obligatory_phone=="1")##
   if(form.phone.value.length<1) {
      return focusedAlert(form.phone, '%%phone_warn%%');
   }
##endif##
##if(check_obligatory_phone_work=="1")##
   if(form.phone_work.value.length<1) {
      return focusedAlert(form.phone_work, '%%phone_work_warn%%');
   }
##endif##
##if(check_obligatory_phone_cell=="1")##
   if(form.phone_cell.value.length<1) {
      return focusedAlert(form.phone_cell, '%%phone_cell_warn%%');
   }
##endif##
##if(check_obligatory_address1=="1")##
   if(form.address1.value.length<1) {
      return focusedAlert(form.address1, '%%address1_warn%%');
   }
##endif##
##if(check_obligatory_address2=="1")##
   if(form.address2.value.length<1) {
      return focusedAlert(form.address2, '%%address2_warn%%');
   }
##endif##
##if(check_obligatory_city=="1")##
   if(form.city.value.length<1) {
      return focusedAlert(form.city, '%%city_warn%%');
   }
##endif##
##if(check_obligatory_state=="1")##
   if(form.state.value.length<1 && (form.country.value=="us" || form.country.value=="ca")) {
      return focusedAlert(form.state, '%%state_warn%%');
   }
##endif##
##if(check_obligatory_zip=="1")##
   if(form.zip.value.length<1 && (form.zip.value.length!=5 && (form.country.value=="us" || form.country.value=="ca"))) {
      return focusedAlert(form.zip, '%%zip_warn%%');
   }
##endif##
  ##if(EMPTY_PASSWORD=="1")##
     if(form.password.value.length>0 || form.password2.value.length>0) {
  ##endif##
  ##if(check_password=="1")##
       if(form.password.value.length<##password_minlength##) {
          return focusedAlert(form.password, '%%pass_warn%% ##password_minlength##');
       }
       if(form.password.value!=cform.password2.value){
          return focusedAlert(form.password, '%%cpass_warn%%');
       }
  ##endif##
  ##if(EMPTY_PASSWORD=="1")##
     }
  ##endif##
##if(MEMBER_SHARED=="1")##
   if(member_changed && !confirm('%%member_changed%%##member_modules##.%%are_you_sure%%')) {
      return false;
   }
##endif##
"-->

<!--#set var="form" value="
##if(EDIT_USERNAME=="0")##
     <tr>
       <td>%%username%%##obligatory_username##:</td>
       <td>
         <input type="text" name="username" class="field field60" value="##username##" maxlength="32">
       </td>
     </tr>
##endif##
##if(show_username=="1")##
  <tr>
    <td>%%username%%:##obligatory_username##</td>
    <td><input type="text" class="field field30" name="username" value="##username##"  maxlength="32"></td>
  </tr>
##endif##

##if(show_email=="1")##
     <tr>
       <td>%%email%%##obligatory_email##:</td>
       <td>
         <input type="text" name="email" class="field field60" value="##email##" maxlength="60">
       </td>
     </tr>
##endif##
##if(show_firstname=="1")##
     <tr>
       <td>%%firstname%%##obligatory_firstname##:</td>
       <td>
         <input type="text" name="firstname" class="field field60" value="##firstname##" maxlength="64">
       </td>
     </tr>
##endif##
##if(show_lastname=="1")##
     <tr>
       <td>%%lastname%%##obligatory_lastname##:</td>
       <td>
         <input type="text" name="lastname" class="field field60" value="##lastname##" maxlength="64">
       </td>
     </tr>
##endif##
##if(show_phone=="1")##
     <tr>
       <td>%%phone%%##obligatory_phone##:</td>
       <td>
         <input type="text" name="phone" class="field field60" value="##phone##" maxlength="24">
       </td>
     </tr>
##endif##
##if(show_phone_work=="1")##
     <tr>
       <td>%%phone_work%%##obligatory_phone_work##:</td>
       <td>
         <input type="text" name="phone_work" class="field field60" value="##phone_work##" maxlength="24">
       </td>
     </tr>
##endif##
##if(show_phone_cell=="1")##
     <tr>
       <td>%%phone_cell%%##obligatory_phone_cell##:</td>
       <td>
         <input type="text" name="phone_cell" class="field field60" value="##phone_cell##" maxlength="24">
       </td>
     </tr>
##endif##
##if(show_address1=="1")##
     <tr>
       <td>%%address1%%##obligatory_address1##:</td>
       <td>
         <input type="text" name="address1" class="field field60" value="##address1##" maxlength="255">
       </td>
     </tr>
##endif##
##if(show_address2=="1")##
     <tr>
       <td>%%address2%%##obligatory_address2##:</td>
       <td>
         <input type="text" name="address2" class="field field60" value="##address2##" maxlength="255">
       </td>
     </tr>
##endif##
##if(show_city=="1")##
     <tr>
       <td>%%city%%##obligatory_city##:</td>
       <td>
         <input type="text" name="city" class="field field60" value="##city##" maxlength="64">
       </td>
     </tr>
##endif##
##if(show_state=="1")##
<script type="text/javascript">
<!--
var member_country = '##member_country##';
var member_state = '##state##';
var usStates = new Object();

##states_js##

function SetStates() {
	var country = document.getElementById('country');
    var state_div = document.getElementById('state_div');
    var state_sel_div = document.getElementById('state_sel_div');
	var state_sel = document.getElementById('state_sel');
    var selected_state = 0;

    if (country.value == "us") {
        state_div.style.display = 'none';
        state_sel_div.style.display = 'block';

        state_sel.options.length = 0;
        var state_ind = 0;
        for(var i in usStates) {
            state_sel.options[state_ind] = new Option(usStates[i], i);
            if (state_sel.options[state_ind].value == member_state) {
                selected_state = state_ind;
            }
            state_ind += 1;
        }
        document.getElementById('state_sel').selectedIndex = selected_state;
        storeState(member_state);
    } else {
        state_div.style.display = 'block';
        state_sel_div.style.display = 'none';
    }
}

function storeState(cur_state) {
    document.getElementById('state').value = cur_state;
}
//-->
</script>
     <tr>
       <td>%%state%%##obligatory_state##:</td>
       <td>
       <div id="state_div">
         <input type="text" name="state" id="state" class="field field60" value="##state##" maxlength="##state_maxlen##">
       </div>
       <div id="state_sel_div" style="display:none;">
         <select name="state_sel" id="state_sel" onChange="storeState(this.value)" style="width:220px;">##state##
         </select>
       </div>
       </td>
     </tr>
##endif##
##if(show_zip=="1")##
     <tr>
       <td>%%zip%%##obligatory_zip##:</td>
       <td>
         <input type="text" name="zip" class="field field60" value="##zip##" maxlength="16">
       </td>
     </tr>
##endif##
##if(show_country=="1")##
     <tr>
       <td>%%country%%##obligatory_country##:</td>
       <td>
        <select name="country" id="country" ##if(show_state=="1")##onChange="SetStates()"##endif## style="width:196px;">
        ##country##
        </select>
       </td>
     </tr>
##endif##
##if(show_company=="1")##
     <tr>
       <td>%%company%%##obligatory_company##:</td>
       <td>
         <input type="text" name="company" class="field field60" value="##company##" maxlength="64">
       </td>
     </tr>
##endif##
##if(show_companyweb=="1")##
  <tr>
    <td>%%website%%:##obligatory_companyweb##</td>
    <td><input type="text" class="field field60" name="companyweb" value="##companyweb##"  maxlength="128"></td>
  </tr>
##endif##
##--if(show_website=="1")##
     <tr>
       <td>%%website%%##obligatory_website##:</td>
       <td>
         <input type="text" name="companyweb" class="field field60" value="##companyweb##" maxlength="128">
       </td>
     </tr>
##endif--##
##if(show_password=="1")##
  <tr>
    <td>%%unsubpass%%:##obligatory_password##</td>
    <td><input type="password" class="field field60" name="password" value="" ></td>
  </tr>
  <tr>
    <td><nobr>%%unsubpass2%%:##obligatory_password##</nobr></td>
    <td><input type="password" class="field field60" name="password2" value="" ></td>
  </tr>
##endif##
##if(show_state=="1")##
<script type="text/javascript">
<!--
    SetStates();
//-->
</script>
##endif##
"-->