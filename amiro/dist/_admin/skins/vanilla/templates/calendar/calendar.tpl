%%include_language "templates/calendar/calendar.lng"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>%%title_calendar%%</title>
    ##metas##
<style>
    body {
        font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-weight: normal;
    }

    .calendar {
        position: absolute;
        left: 0px;
        top: 0px;
        width: 200px;
        height: 268px;
    }
    .dayofweek {
        font-size: 10px;
        font-weight: normal;
    }
    .month {
        font-size: 13px;
    }
    .date {
        width: 10%;
        height: 28px;
        padding-right: 3px;
        text-align: right;
        vertical-align: top;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
        cursor: pointer;
    }
    .selected {
        width: 10%;
        height: 28px;
        padding-right: 3px;
        text-align: right;
        vertical-align: top;
        font-weight: bold;
        font-size: 13px;
        cursor: pointer;
        cursor: pointer;
    }
    .empty {
        width: 10%;
        height: 28px;
        font-size: 13px;
    }
    a {
        font-weight: bold;
        font-size: 16px;
        color: #103463;
        text-decoration: none
    }
    form {
        padding: 0px;
        margin: 0px;
    }
    select {
        font-size: 10px;
    }
    input.but {
        color: #bc4702;
        font-weight: normal;
        height: 25px;
        background: #FFCE72;
        border: 1px solid #FFCE72;
        border-radius: 3px;
        line-height: 1.5;
        font-size: 11px;
        margin: 0px 0px 5px 0px;
    }
    
    .button {
        width: 27px;
        height: 16px;
        cursor: pointer;
        background-color: #fff;
        border: 1px #c0c0c0 solid;
        padding: 5px 0px;
    }   

    input[name=txt_year], select[name=sel_month] {
        font-weight: normal;
        width: 50px;
        height: 28px;
        padding: 1px 10px !important;
        border-radius: 6px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        border: 1px solid #DBE1E8;
        margin-bottom: 5px;
    }
    
    select[name=sel_month] {
        width: auto;
        margin-bottom: 0px;        
    }
    
    .buttons_left, .buttons_right {
        width: 30px;
    }
    
    .buttons_right {
        text-align: left;
    }


</style>

<script>

function fireEvent2(eventElement, eventName){
    if(document.createEventObject){
        var event = document.createEventObject();
        eventElement.fireEvent("on" + eventName, event);
    }else if(document.createEvent){
        var event = document.createEvent("HTMLEvents");
        event.initEvent(eventName, false, false);
        eventElement.dispatchEvent(event);
    }else{
        return false;
    }
}

function getSrcElement(event){
    return event.srcElement ? event.srcElement : event.target;
}

// {{{ y2k()
var editorBaseHref = '##root_path_www##';

function y2k(number)
{
    return (number < 1000) ? number + 1900 : number;
}

var calendarStartMonday = parent.calendarStartMonday;
var calendarFormat = parent.calendarFormat;
var calendarColors = parent.calendarColors;
var calendarMonths = parent.calendarMonths;
var calendarWeekdays = parent.calendarWeekdays;
var calendarDays = parent.calendarDays;
var calendarBlock = parent.calendarBlock;

// get the reference to the target element and setup the date
if (typeof(calendarBlock)=='object'){

  var targetDateField = parent.calendarTarget;
  var showMinDateButton = parent.showMinDateButton;
  var showMaxDateButton = parent.showMaxDateButton;
  var dateString = targetDateField.value;

  if (dateString != '' &&
     (typeof(parent.calendarUseToday) == 'undefined' || !parent.calendarUseToday)) {
      // convert the user format of the date into something we use to make a javascript Date object
      // we need to pad with placeholders to get the rigth offset
  //    tmp_format = calendarFormat.replace(/m/i, 'mm').replace(/d/i, 'dd').replace(/y/i, 'yyyy');
      tmp_format = calendarFormat;
      year_len = 2;
      if(tmp_format.indexOf('YYYY')>=0) year_len = 4;
      tmp_yOffset = tmp_format.indexOf('Y');
      tmp_mOffset = tmp_format.indexOf('M');
      tmp_dOffset = tmp_format.indexOf('D');
      year_pref = '20';
      if(year_len == 4) year_pref = '';
      if(year_len == 2){
         var cur_y = dateString.substring(tmp_yOffset, tmp_yOffset + year_len);
	 if(cur_y > 69){
            year_pref = '19';
         }
      }

      var current_day = new Date(year_pref + dateString.substring(tmp_yOffset, tmp_yOffset + year_len), dateString.substring(tmp_mOffset, tmp_mOffset +
   2) - 1, dateString.substring(tmp_dOffset, tmp_dOffset + 2));
      if ((current_day == "Invalid Date") || (isNaN(current_day))) {
          var current_day = new Date();
      }
  }
  // use today's date
  else {
      var current_day = new Date();
  }

  var today = new Date();

  var day = current_day.getDate();
  var year  = y2k(current_day.getYear());
  var month = current_day.getMonth();

  var currentDay = day;
  var currentYear = year;
  var currentMonth = month;

  var todayDay = today.getDate();
  var todayYear = y2k(today.getYear());
  var todayMonth = today.getMonth()+1;
}

function yearback(){
  if (year>##MIN_YEAR##){
    year--;
  }else{
    year=##MIN_YEAR##;
  }
  thisYear  = year;
}

function yearforward(){
  if (year<##MAX_YEAR##){
    year++;
  }else{
    year=##MAX_YEAR##;
  }
  thisYear  = year;
}

function previousmonth(){
    if (month > 0) {
        month--;
    }
    else {
        month = 11;
        yearback();
    }  
    thisMonth = month;
}

function nextmonth(){
    if (month < 11) {
        month++;
    }
    else {
        month = 0;
        yearforward();
    }
    thisMonth = month;
}

function printDate(month, day, year){
    month = month < 10 ? '0' + month : month;
    day   = day   < 10 ? '0' + day   : day;
    syear = year.toString();
    syear = syear.substr(2,2);
    selectedDate = calendarFormat;
    selectedDate = selectedDate.replace(/MM/, month);
    selectedDate = selectedDate.replace(/DD/, day);
    selectedDate = selectedDate.replace(/YYYY/, year);
    selectedDate = selectedDate.replace(/YY/, syear);
    return selectedDate;
}

function sendDate(month, day, year){
    selectedDate = printDate(month, day, year);
    var fields = top.document.getElementsByName(targetDateField.name);
    for(var i in fields){
        fields[i].value = selectedDate;
    }
    var fields = top.document.getElementsByName('enc_' + targetDateField.name);
    for(var i in fields){
        fields[i].value = selectedDate;
    }
    fireEvent2(targetDateField, 'change');
    calendarBlock.style.display="none";
}

function clearTimeField(){
    var timeField = top.document.getElementsByName(targetDateField.name + '_time');
    if(typeof(timeField[0]) !== 'undefined' && timeField[0] != null){
        timeField[0].value = '';
    }
}

function setDate(month, day, year){
   printCalendar(month);
   //selectedDate = printDate(month, day, year);
 }

function colorize (which, toggle, type){ 
    if ((document.all) || (document.getElementById)) {
        if (toggle == 1) { 
            which.style.color = calendarColors['dateHoverColor'];
            which.style.backgroundColor = calendarColors['dateHoverBgColor'];
        }
        else {
            which.style.color = calendarColors[type + 'Color'];
            which.style.backgroundColor = calendarColors[type + 'BgColor'];
        }
    }
}

var thisDay   = day;
var thisMonth = month;
var thisYear  = year;
var popupMove = false;
var popupCorrectX;
var popupCorrectY;
var popupStartX;
var popupStartY;
var popupBlock;

var yeararray = new Array();
for (year_cnt = 1; year_cnt <= 21; year_cnt++) {
    yeararray[year_cnt] = thisYear - 11 + year_cnt;
}

function printCalendar(whichMonth){
  document.getElementById("calendar_body").innerHTML = calendar(whichMonth,thisYear);
  document.calendar_form.txt_year.value = thisYear;
  document.calendar_form.sel_month.value = thisMonth;
  document.calendar_form.todayDateButton.value='%%today%% '+ printDate(todayMonth, todayDay, todayYear);
}

function calendar(month, year) {
    var realMonth = parseInt(month) + 1;
    // we need to put in the zero placeholders
    if (realMonth < 10) {
        realMonth = '0' + realMonth;
    }

    var realDate = '';
    var output = '';
       
    firstDay = new Date(year, month, 1);
    startDay = firstDay.getDay();
    weekdayOffset = 0;
    if (calendarStartMonday) {
        if (startDay) {
            startDay--;
        }
        else {
            startDay = 6;
        }

        weekdayOffset++;
    }


    // Determined whether this is a leap year or not
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        calendarDays[1] = 29; 
    }
    else {
        calendarDays[1] = 28;
    }

    output += '<table border="0" cellspacing="0" cellpadding="5" width="100%">';
    output += '<tr><td colspan="3" valign="top"><table border="0" cellspacing="1" cellpadding="0" width="100%">';
    output += '<tr class="dayofweek">';
    // print out the days of the week
    for (i = weekdayOffset; i < 7 + weekdayOffset; i++) {
        output += '<th width=14% bgColor="'+((i<6)?calendarColors['headerBgColor']:calendarColors['headerWeekDaysBgColor'])+'" style="color: '+calendarColors['headerColor']+';font-face:Verdana">' + calendarWeekdays[i] + '</th>';
    }
    output += '<tr>';
    var column = 0;
    for (i = 0; i < startDay; i++) {
        output += '<td class="empty" style="background-color: '+calendarColors['bgColor']+';">&nbsp;</td>';
        column++;
    }

    for (i = 1; i <= calendarDays[month]; i++) {
        realDate = i;
        // add the zero place holder
        if (realDate < 10) {
            realDate = '0' + realDate
        }
         
        if ((i == currentDay)  && (month == currentMonth) && (year == currentYear)) {
            output += '<td class="selected" style="background-color: '+calendarColors['dateSelectedBgColor']+'; color: '+calendarColors['dateSelectedColor']+';" onmouseover="colorize(this,1,\'dateSelected\');" onmouseout="colorize(this,0,\'dateSelected\');" onclick="sendDate('+realMonth+', '+realDate+', '+year+');">';
            output += i;
            output += '</td>';
        }
        else {
            output += '<td class="date" style="background-color: '+(column==5 || column==6 ? calendarColors['holidayBgColor'] : calendarColors['dateBgColor'])+'; color: '+(column==5 || column==6 ? calendarColors['holidayColor'] : calendarColors['dateColor'])+';" onmouseover="colorize(this,1,\'date\');" onmouseout="colorize(this,0,\''+(column==5 || column==6 ? 'holiday':'date')+'\');" onclick="sendDate('+realMonth+', '+realDate+', '+year+');">';
            output += i;
            output += '</td>';
        }

        column++;
        // end the week
        if (column == 7) {
            output += '</tr>\n<tr>';
            column = 0;
        }
    }

    for(j = calendarDays[month]; j < 42-startDay; j++) {
        output += '<td class="empty" style="background-color: '+calendarColors['bgColor']+';" >&nbsp;</td>';
        column++;
        // end the week
        if (column == 7) {
            output += '</tr>\n<tr>';
            column = 0;
        }
    }
     
    output += '</tr></table>';

    return output;
}

function yearKeyDown(evt){
  evt = evt ? evt : window.event;
  var target = getSrcElement(evt);
  if(evt.keyCode==38){
    yearforward();printCalendar(month, year);target.select();
    return;
  }else if(evt.keyCode==40){
    yearback();printCalendar(month, year);target.select();
    return;
  }
}

function yearKeyPress(){
  window.setTimeout(function(){
    if(document.calendar_form.txt_year.value.length < 4){
      return;
    }
    var newValue = parseInt(document.calendar_form.txt_year.value);
    if(newValue>=##MIN_YEAR## && newValue<=##MAX_YEAR##  && newValue !=thisYear){
      thisYear = year = newValue;
      document.getElementById("calendar_body").innerHTML = calendar(month, year);
      //printCalendar(month, year);
    }else{
      if (newValue<##MIN_YEAR##){
        alert('%%min_year_msg%% ##MIN_YEAR##');
        document.calendar_form.txt_year.value = newValue = ##MIN_YEAR##;
      }
      if (newValue>##MAX_YEAR##){
        alert('%%max_year_msg%% ##MAX_YEAR##');
        document.calendar_form.txt_year.value = newValue = ##MAX_YEAR##;
      }
    }
  }, 10);

}

function _CloseOnEsc(evt) {
  evt = evt ? evt : window.event;
  if (evt.keyCode == 27){
    calendarBlock.style.display='none';
    return;
  }
}

function Init(){
  if (typeof(calendarBlock)=='object'){
    printCalendar(thisMonth);
    popupBlock = calendarBlock;
    document.getElementById('todayDateButton').style.display='block';
    document.getElementById('minDateButton').style.display=(showMinDateButton)?'block':'none';
    document.getElementById('maxDateButton').style.display=(showMaxDateButton)?'block':'none';
    document.body.onkeypress = _CloseOnEsc;
  }
}

//--></script>
</head>
<body alink="#000000" onload="Init();" style="overflow:hidden; margin:0px;" bgcolor="#F8F8F8" onmousemove="return false;">

        <table width=100% cellpadding=0 cellspacing=0 border=0 style="cursor:default;">
            <tr style="background: #E8E8E6;">
                <td style="height:30px;color:#666;font-size:12px;font-weight:bold;padding-left:10px;" width=100%>%%calendar%%</td>
                <td align=center valign=middle style="padding-right:3px;font-size:0px;"><img src="skins/vanilla/icons/icon_popup_close_btn.gif"
                onclick="calendarBlock.style.display='none'; return false;" title="%%close_btn%%"></td>
            </tr>
        </table>

        <div>
            <form name=calendar_form style="margin:0px" onsubmit="year=this.txt_year.value; thisYear  = year; printCalendar(month, year);return false;">
                <center>
                    <table border="0" cellspacing="0" cellpadding="6" width=100%>
                        <tr>
                            <td align=left valign=middle class="buttons_left"><img class=button onclick="yearback();printCalendar(month, year);return false;" title="%%prev_year%%" src="skins/vanilla/icons/icon_arr_left.gif">
                            <br>
                            <img class=button onclick="previousmonth();printCalendar(month, year);return false;" title="%%prev_month%%" src="skins/vanilla/icons/icon_arr_left.gif"></td>
                            <td align="center">
                            <input name=txt_year type=text onchange="year=this.value; thisYear  = year; printCalendar(month, year);return false;" onfocus="this.select()"
                            onkeydown='yearKeyDown(event);' onkeypress='yearKeyPress();' onpaste='yearKeyPress();' maxlength=4>
                            <br>
                            <select name=sel_month onchange="month=this.options[this.selectedIndex].value; thisMonth  = month; printCalendar(month, year);return false;" >
                                <option value='0'>%%m_jan%%</option>
                                <option value='1'>%%m_feb%%</option>
                                <option value='2'>%%m_mar%%</option>
                                <option value='3'>%%m_apr%%</option>
                                <option val
                                ue='4'>%%m_may%%</option>
                                <option value='5'>%%m_jun%%</option>
                                <option value='6'>%%m_jul%%</option>
                                <option value='7'>%%m_aug%%</option>
                                <option value='8'>%%m_sep%%</option>
                                <option value='9'>%%m_oct%%</option>
                                <option value='10'>%%m_nov%%</option>
                                <option value='11'>%%m_dec%%</option>
                            </select></td>
                            <td align=right valign=middle class="buttons_right"><img class=button onclick="yearforward();printCalendar(month, year);return false;" title="%%next_year%%" src="skins/vanilla/icons/icon_arr_right.gif">
                            <br>
                            <img class=button onclick="nextmonth();printCalendar(month, year);return false;" title="%%next_month%%" src="skins/vanilla/icons/icon_arr_right.gif"></td>
                            </tr>
                            </table>
                            </center>
                            <div id=calendar_body></div>

                <table width=100% cellpadding=5 cellspacing=0 border=0>
                    <tr>
                        <td>
                        <input id='todayDateButton' type=button class='but fieldDate' value='%%today%%' onclick='sendDate(todayMonth,todayDay,todayYear);clearTimeField();' style='width:100%;display:none;'>
                        <input id='minDateButton' type=button class='but fieldDate' value='%%min_date%%' onclick='sendDate(##MIN_MONTH##,##MIN_DAY##,##MIN_YEAR##)' style='width:100%;display:none;'>
                        <input id='maxDateButton' type=button class='but fieldDate' value='%%max_date%%' onclick='sendDate(##MAX_MONTH##,##MAX_DAY##,##MAX_YEAR##)' style='width:100%;display:none;'>
                    </tr></td>
                </table>
            </form>
        </div>
    </body>

    </html>

