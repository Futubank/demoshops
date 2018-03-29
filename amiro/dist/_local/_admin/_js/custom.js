var clockColor;

  nn = (document.getElementById && navigator.appName == "Netscape") ? 1 : 0;
  ie = (!nn && document.all) ? 1 : 0;

function getRTime(){

  clockS -= 15;

  if (clockS < 0){

    clockS = 59;
    clockM -= 1;

    if (clockM < 0)
      clockM = 59;
  }

  var sSec = clockS;

  if ( String(clockS).length < 2)
    sSec = "0"+ clockS;

  var sMin = clockM;

  if ( String(clockM).length < 2)
    sMin = "0"+ clockM;

  clockColor = "blue";

  if (clockM < 20)
    clockColor="green";
  if (clockM < 10)
    clockColor="red";

  return sMin+":"+sSec; 

}


function showTime()
{


  if ((typeof(clockS)=="number") && typeof(clockM)=="number"){  

    STime=getRTime(); 

    if (document.all["clock"] ){

      var clock = document.all["clock"];
    
      clock.innerHTML=STime;

      clock.style.color=clockColor;

    }
    if ( ie )
      timerId=setTimeout("showTime()",15000);
  }
}

showTime()
