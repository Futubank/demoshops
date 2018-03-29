%%include_language "templates/calendar/calendar.lng"%%
%%include_language "templates/lang/main.lng"%%

var calendarWindow = null;
var calendarColors = new Array();
calendarColors['bgColor'] = '#f0f0f0';
calendarColors['borderColor'] = '#A0A0A0';
calendarColors['headerBgColor'] = '#143464';
calendarColors['headerWeekDaysBgColor'] = '#CC0000';
calendarColors['headerColor'] = '#FFFFFF';
calendarColors['dateBgColor'] = '#A0A0A0';
calendarColors['dateColor'] = '#004080';
calendarColors['holidayColor'] = '#CC0000';
calendarColors['holidayBgColor'] = '#C0C0C0';
calendarColors['dateHoverBgColor'] = '#FFD78C';
calendarColors['dateHoverColor'] = '#000000';
calendarColors['dateSelectedColor'] = '#FFFFFF';
calendarColors['dateSelectedBgColor'] = '#DDA56E';

var calendarMonths = new Array('%%m_jan%%', '%%m_feb%%', '%%m_mar%%', '%%m_apr%%', '%%m_may%%', '%%m_jun%%', '%%m_jul%%', '%%m_aug%%', '%%m_sep%%', '%%m_oct%%', '%%m_nov%%', '%%m_dec%%');
var calendarWeekdays = new Array('S', '%%d_mon%%', '%%d_tue%%', '%%d_wed%%', '%%d_thu%%', '%%d_fri%%', '%%d_sat%%', '%%d_sun%%');
var calendarUseToday = false;
var calendarFormat = '##date_format##';
var calendarStartMonday = true;
var calendarDays  = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var calendarBlock ;
var calendarDateFieldName;

var calendarTarget = null;

// }}}
// {{{ getCalendar()

function getCalendar(evt, in_dateField, showBoundDateButtons)
{

    showMinDateButton = 0;
    showMaxDateButton = 0;

    if(typeof(showBoundDateButtons) == 'string') {
        if(showBoundDateButtons == 'MIN' || showBoundDateButtons == 'MIN_MAX') {
            showMinDateButton = 1;
        }
        if(showBoundDateButtons == 'MAX' || showBoundDateButtons == 'MIN_MAX') {
            showMaxDateButton = 1;
        }
    }

    calendarTarget = in_dateField;
    calendarBlock = document.getElementById("calendar_block");
    if (calendarBlock.style.display!="block" || (in_dateField.form.name + in_dateField.name!=calendarDateFieldName)){
      calendarDateFieldName = in_dateField.form.name + in_dateField.name;
      cLeft = getx(amiCommon.getEventTarget(amiCommon.getValidEvent(evt)))+amiCommon.getEventTarget(amiCommon.getValidEvent(evt)).offsetWidth;
      cTop = gety(amiCommon.getEventTarget(amiCommon.getValidEvent(evt)))+amiCommon.getEventTarget(amiCommon.getValidEvent(evt)).offsetHeight;
      document.getElementById("calendar_block_frm").src = "calendar.php?a&_cv="+cms_version;

      var correctLeft = cLeft + calendarBlock.offsetWidth - getScrollLeft() - parseInt(document.body.clientWidth);
      var correctTop = cTop + calendarBlock.offsetHeight - getScrollTop() - parseInt(document.body.clientHeight);
      var Left = cLeft - ((correctLeft > 0)?correctLeft:0);
      var Top = cTop - ((correctTop > 0)?correctTop:0);

      calendarBlock.style.left = Left - 15 + 'px';
      calendarBlock.style.top = Top - 15 + 'px';
      if(calendarBlock.style.display!="block"){
        flyPopup( function(){document.getElementById("calendar_block").style.display = "block"; flyPopupClose(); }, Left - 15, Top - 15, 220, 347, 5 );
      }
    }else{
      calendarBlock.style.display = "none";
    }
    return false;
}



