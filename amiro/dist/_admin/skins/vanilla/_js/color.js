var colorSetB;
var colorSetHS;
var colorHSTableX;
var colorHSTableY;
var colorBTableX;
var colorBTableY;

  function color_tables_set(sColor){
		errFunc = color_tables_set;  
		if (sColor == "" || sColor == null)	return;
    var oForm = document.forms['color_picker'];
    var aRGB = hex2rgb(sColor);
    oForm.elements['color_rgb_r'].value = aRGB[0];
    oForm.elements['color_rgb_g'].value = aRGB[1];
    oForm.elements['color_rgb_b'].value = aRGB[2];
    sColor = rgb2hex(oForm.elements['color_rgb_r'].value, oForm.elements['color_rgb_g'].value, oForm.elements['color_rgb_b'].value);
    oForm.elements['color_html'].value = sColor
    document.getElementById('color_selected').style.backgroundColor = sColor;
    var aHSB = rgb2hsb(aRGB[0], aRGB[1], aRGB[2]);
    oForm.elements['color_hsb_h'].value = aHSB[0];
    oForm.elements['color_hsb_s'].value = aHSB[1];
    oForm.elements['color_hsb_b'].value = aHSB[2];

    colorHSTableX = getx(document.getElementById('color_hs_table'));
    colorHSTableY = gety(document.getElementById('color_hs_table'));
    colorBTableX  = getx(document.getElementById('color_b_table'));
    colorBTableY  = gety(document.getElementById('color_b_table'));


    document.getElementById('color_hs_pointer').style.left= Math.round( 256 / 360 * aHSB[0]) - 6 + getx(document.getElementById('color_hs_table')) +  getScrollLeft()+'px';
    document.getElementById('color_hs_pointer').style.top= Math.round( 256 / 100 * (100 - aHSB[1])) - 6 + gety(document.getElementById('color_hs_table')) +  getScrollTop() + 'px';

    document.getElementById('color_b_pointer').style.left = getx(document.getElementById('color_b_table')) - 5 +  getScrollLeft()+'px';
    document.getElementById('color_b_pointer').style.top = Math.round( 256 / 100 * (100 - aHSB[2])) - 7 + gety(document.getElementById('color_b_table')) +  getScrollTop() + 'px';

    document.getElementById('color_hs_pointer').style.display = "block";
    document.getElementById('color_b_pointer').style.display = "block";

    setOpacity(document.getElementById('color_hs_table'), parseInt(oForm.elements['color_hsb_b'].value) / 100);

    var hsRGB = hsb2rgb(oForm.elements['color_hsb_h'].value, oForm.elements['color_hsb_s'].value, 100);
    document.getElementById('color_b_table').style.backgroundColor = rgb2hex(hsRGB[0], hsRGB[1], hsRGB[2]);
    
    checkColor();
  }
  
  function color_b_set(evt, r, g, b){
    evt = amiCommon.getValidEvent(evt);
    var target = amiCommon.getEventTarget(evt);
	errFunc = color_b_set;  
  	var clientY = evt.clientY + getScrollTop();
	  var clientX = evt.clientX + getScrollLeft();

    if (colorSetB || clientY - colorBTableY < 0 || clientY - colorBTableY > 255 )
      return;
    colorSetB = true;
    var oForm = document.forms['color_picker'];
    oForm.elements['color_hsb_b'].value = Math.round(100 -  ( clientY - colorBTableY)  / 256 * 100);
	  color_hsb_set();
    colorSetB = false;
  }


  function color_hs_set(evt){
    evt = amiCommon.getValidEvent(evt);
    var target = amiCommon.getEventTarget(evt);
		errFunc = color_hs_set;  
    if (colorSetHS || evt.clientX - colorHSTableX < 0 || evt.clientX - colorHSTableX > 255 || evt.clientY - colorHSTableY < 0 || evt.clientY - colorHSTableY > 255)
      return;
    colorSetHS = true;
    document.getElementById('color_hs_pointer').style.left = evt.clientX - 6+'px';
    document.getElementById('color_hs_pointer').style.top = evt.clientY - 6+'px';
    var oForm = document.forms['color_picker'];
    oForm.elements['color_hsb_h'].value = Math.round((evt.clientX - colorHSTableX ) / 256 * 360);
    oForm.elements['color_hsb_s'].value = Math.round(100 -  (evt.clientY -  colorHSTableY) / 256 * 100);
    if (!colorBChanged && oForm.elements['color_hsb_b'].value == '0')
      oForm.elements['color_hsb_b'].value = '100';
	  color_hsb_set();
    colorSetHS = false;
  }

  function color_hsb_set(){
    errFunc = color_hsb_set;  
    var oForm = document.forms['color_picker'];
    var aRGB = hsb2rgb(oForm.elements['color_hsb_h'].value, oForm.elements['color_hsb_s'].value, oForm.elements['color_hsb_b'].value);
    oForm.elements['color_rgb_r'].value = aRGB[0];
    oForm.elements['color_rgb_g'].value = aRGB[1];
    oForm.elements['color_rgb_b'].value = aRGB[2];
    sColor = rgb2hex(oForm.elements['color_rgb_r'].value, oForm.elements['color_rgb_g'].value, oForm.elements['color_rgb_b'].value);
    oForm.elements['color_html'].value = sColor
    document.getElementById('color_selected').style.backgroundColor = sColor;
    document.getElementById('color_b_pointer').style.left = getx(document.getElementById('color_b_table')) - 5 + 'px';
    document.getElementById('color_b_pointer').style.top = Math.round( 256 / 100 * (100 - oForm.elements['color_hsb_b'].value)) - 7 + gety(document.getElementById('color_b_table')) +  getScrollTop()+'px';
    document.getElementById('color_hs_pointer').style.left= Math.round( 256 / 360 * oForm.elements['color_hsb_h'].value) - 6 + getx(document.getElementById('color_hs_table')) +  getScrollLeft()+'px';
    document.getElementById('color_hs_pointer').style.top= Math.round( 256 / 100 * (100 - oForm.elements['color_hsb_s'].value)) - 6 + gety(document.getElementById('color_hs_table')) +  getScrollTop()+'px';

    setOpacity(document.getElementById('color_hs_table'), parseInt(oForm.elements['color_hsb_b'].value) / 100);

    var hsRGB = hsb2rgb(oForm.elements['color_hsb_h'].value, oForm.elements['color_hsb_s'].value, 100);
    document.getElementById('color_b_table').style.backgroundColor = rgb2hex(hsRGB[0], hsRGB[1], hsRGB[2]);

    checkColor();
  }

  function color_rgb_set(){
		errFunc = color_rgb_set;  
    var oForm = document.forms['color_picker'];
    aHSB = rgb2hsb(oForm.elements['color_rgb_r'].value, oForm.elements['color_rgb_g'].value, oForm.elements['color_rgb_b'].value);
    sColor = rgb2hex(oForm.elements['color_rgb_r'].value, oForm.elements['color_rgb_g'].value, oForm.elements['color_rgb_b'].value);

    oForm.elements['color_hsb_h'].value = aHSB[0];
    oForm.elements['color_hsb_s'].value = aHSB[1];
    oForm.elements['color_hsb_b'].value = aHSB[2];

  	oForm.elements['color_html'].value = sColor

    document.getElementById('color_selected').style.backgroundColor = sColor;

    document.getElementById('color_b_pointer').style.left = getx(document.getElementById('color_b_table')) - 5+'px';
    document.getElementById('color_b_pointer').style.top = Math.round( 256 / 100 * (100 - oForm.elements['color_hsb_b'].value)) - 7 + gety(document.getElementById('color_b_table')) +  getScrollTop()+'px';
    document.getElementById('color_hs_pointer').style.left= Math.round( 256 / 360 * oForm.elements['color_hsb_h'].value) - 6 + getx(document.getElementById('color_hs_table')) +  getScrollLeft()+'px';
    document.getElementById('color_hs_pointer').style.top= Math.round( 256 / 100 * (100 - oForm.elements['color_hsb_s'].value)) - 6 + gety(document.getElementById('color_hs_table')) +  getScrollTop()+'px';

	var hsRGB = hsb2rgb(oForm.elements['color_hsb_h'].value, oForm.elements['color_hsb_s'].value, 100);
	hsColor = rgb2hex(hsRGB[0], hsRGB[1], hsRGB[2]);
	setRuntimeStyle(document.getElementById('color_hs_table'), "filter", "Alpha(opacity="+ (parseInt(oForm.elements['color_hsb_b'].value))+")");
// ###
    //document.getElementById('color_b_table').style.cssText = "filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='"+hsColor+"',EndColorStr='#000000')";

    setOpacity(document.getElementById('color_hs_table'), parseInt(oForm.elements['color_hsb_b'].value) / 100);

    var hsRGB = hsb2rgb(oForm.elements['color_hsb_h'].value, oForm.elements['color_hsb_s'].value, 100);
    document.getElementById('color_b_table').style.backgroundColor = rgb2hex(hsRGB[0], hsRGB[1], hsRGB[2]);

    checkColor();
  }
	
  function checkColor(){
		errFunc = checkColor;  
    var oForm = document.forms['color_picker'];
    var bCorrect = true;
    var iR = parseInt(oForm.elements['color_rgb_r'].value);
    var iG = parseInt(oForm.elements['color_rgb_g'].value);
    var iB = parseInt(oForm.elements['color_rgb_b'].value);

    var iRC = Math.round( iR / 51) * 51;
    var iGC = Math.round( iG / 51) * 51;
    var iBC = Math.round( iB / 51) * 51;

    if ( iR != iRC || iG != iGC || iB != iBC)
      bCorrect = false;

    if (bCorrect){
      document.getElementById('color_wc_block').style.visibility='hidden';
    }else{
      document.getElementById('color_wc_block').style.visibility='visible';
      document.getElementById('color_web_corrected').style.backgroundColor = rgb2hex(iRC, iGC, iBC);
    }
  }

  function correctColor(){
    errFunc = correctColor;  
    var oForm = document.forms['color_picker'];
    color_tables_set(document.getElementById('color_web_corrected').style.backgroundColor);
  }
  
  function hsb2rgb(h,s,v){
    errFunc = hsb2rgb;  
    var i, f, p, q, t, retval;
    h = parseFloat(h/360);
    s = parseFloat(s/100);
    v = parseFloat(v/100);
    if(h >= 1.0) h %= 1.0; 
    if(s > 1.0) s = 1.0;
    if(v > 1.0) v = 1.0;
    
    var tov = Math.floor(255 * v);
    if(s == 0.0){
      retval = new Array(tov,tov,tov);
    }
    else
    {
      h *= 6.0;
      i = Math.floor(h);
      f = h - i;
      p = Math.floor(tov * (1.0 - s));
      q = Math.floor(tov * (1.0 - (s * f)));
      t = Math.floor(tov * (1.0 - (s * (1.0  - f))));
      if(i == 0) retval = new Array(tov,t,p);
      if(i == 1) retval = new Array(q,tov,p);
      if(i == 2) retval = new Array(p,tov,t);
      if(i == 3) retval = new Array(p,q,tov);
      if(i == 4) retval = new Array(t,p,tov);
      if(i == 5) retval = new Array(tov,p,q);
    
    }
    return retval;
  }

 function dec2hex(decimal) {
   errFunc = dec2hex;  
   var hex;
   var hexChars = "0123456789ABCDEF";
   var a = decimal % 16;
   var b = (decimal - a)/16;
   hex = "" + hexChars.charAt(b) + hexChars.charAt(a);
   return hex;
 }

 function rgb2hex(r,g,b){
   errFunc = rgb2hex;  
   return "#" + dec2hex(r) + dec2hex(g) + dec2hex(b);
 }
 
 function hex2rgb(hex){
   errFunc = hex2rgb;  
   var re = /#/gi;
   hex = hex.replace(re,"");
   var arrayRGB = new Array();
   arrayRGB[0] = parseInt(hex.substr(0,2), 16);
   arrayRGB[1] = parseInt(hex.substr(2,2), 16);
   arrayRGB[2] = parseInt(hex.substr(4,2), 16);
   return arrayRGB;
 }
 
 function rgb2hsb(r, g, b){
   errFunc = rgb2hsb;  
   r = parseFloat(r);
   g = parseFloat(g);
   b = parseFloat(b);
   var hue, saturation, brightness;
   hsbvals = new Array(3);
   var cmax = (r > g) ? r : g;
   if (b > cmax) cmax = b;
   var cmin = (r < g) ? r : g;
   if (b < cmin) cmin = b;
   brightness = cmax / 255.0;
   if (cmax != 0){
       saturation = (cmax - cmin) / cmax;
   }
   else{
       saturation = 0;
   }
   if (saturation == 0){
       hue = 0;
   }
   else {
       var redc = (cmax - r) / (cmax - cmin);
       var greenc = (cmax - g) / (cmax - cmin);
       var bluec = (cmax - b) / (cmax - cmin);
       if (r == cmax){
           hue = bluec - greenc;
       }
       else if (g == cmax){
           hue = 2.0 + redc - bluec;
       }
       else{
           hue = 4.0 + greenc - redc;
       }
       hue = hue / 6.0;
       if (hue < 0) hue = hue + 1.0;
   }
   hsbvals[0] = Math.round(hue * 360);
   hsbvals[1] = Math.round(saturation*100);
   hsbvals[2] = Math.round(brightness*100);
   return hsbvals;

 }

 function getx(elem){
  errFunc = getx;  
  x = 0;
  do { x += elem.offsetLeft; }
  while((elem = elem.offsetParent) != null);
  return x;
 }

function gety(elem){
  errFunc = gety;  
  y = 0;
  do { y += elem.offsetTop; }
  while((elem = elem.offsetParent) != null);
  return y;
}

