
<!--#set var="body" value="

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<body>

##specbody##

<br><br><hr><br><br>
<b>SITE</b><br>
<table>
<tr>
	<td>Domain: <a href="http://##domain##/">##domain##</a></td>
	<td>Username: <b>##username##</b></td>
	<td>Home dir: <b>##home_dir##</b></td>
	<td>Database: <b>##dbase##</b></td>
</tr>
<tr>
	<td>Site status: <b>##status##</b></td>
	<td>Admin status: <b>##admin_status##</b></td>
	<td>FTP: <b>##ftp_status##</b></td>
	<td>Ignored by exp. daemon: <b>##exp_daemon_ignore##</b></td>
</tr>
<tr>
	<td>Reg. date: <b>##date_registered##</b></td>
	<td>Licence: <b>##licence_exp_date##</b></td>
	<td>Lic. type: <b>##licence_type##</b></td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>Traf. quota: <b>##traf_quota##</b></td>
	<td>Disk quota: <b>##disk_quota##</b></td>
	<td>Email quota: <b>##email_quota##</b></td>
	<td>Max. mboxes: <b>##max_mboxes##</b></td>
</tr>
<tr>
	<td>Disk space used: <b>##disk_space##</b></td>
	<td>Email space used: <b>##email_space_used##</b></td>
	<td>DB size: <b>##db_size##</b></td>
</tr>
</table>
<br><br>
<b>ACCOUNT</b><br>
<table>
<tr>
	<td>Balance: <b>##amount##</b></td>
	<td>Min. balance: <b>##amount_min##</b></td>
	<td>Price: <b>##amount_month##</b></td>
	<td>Paid until: <b>##date_amount_zero##</b></td>
</tr>
<tr>
	<td>Billing OFF: <b>##billing_off##</b></td>
	<td>Next billing: <b>##billing_date##</b></td>
	<td>Traf over: <b>##traf_price##/##traf_amount##</b></td>
	<td>Last remind: <b>##date_last_remind_sent##</b></td>
</tr>
<tr>
	<td>Last payment: <b>##last_payment_amount##</b></td>
	<td>Last payment date: <b>##last_payment_date##</b></td>
	<td>Note: <b>##note##</b></td>
	<td>Hidden note: <b>##hidden_note##</b></td>
</tr>
</table>

</body>
</html>
"-->
