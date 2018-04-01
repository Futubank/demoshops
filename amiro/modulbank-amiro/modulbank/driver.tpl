<!--#set var="settings_form" value="
    <tr>
        <td>%%merchant_id%%:</td>
        <td><input type="text" name="merchant_id" class="field" value="##merchant_id##" size="40"></td>
    </tr>
    <tr>
        <td>%%secret_key%%:</td>
        <td><input type="text" name="secret_key" class="field" value="##secret_key##" size="40"></td>
    </tr>
    <tr>
        <td>%%test_mode%%:</td>
        <td><input type="checkbox" name="test_mode" class="field" value="1" "##IF(test_mode)## checked="checked"##ENDIF## ></td>
    </tr>
"-->
