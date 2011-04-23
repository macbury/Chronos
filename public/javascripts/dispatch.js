var previousPoint = null;

function showTooltip(x, y, contents) {
  $('<div id="tooltip" class="tooltip">' + contents + '</div>').css( {
      position: 'absolute',
      display: 'none',
      top: y + 5,
      left: x + 5,
  }).appendTo("body").fadeIn(200);
}
var client = null;
var auth_token = 0;

$(document).ready(function(){
  App.Router = new Router();
  
  if(window["Faye"]) {
    App.Faye = new Faye.Client($('meta[name=notifications_server]').attr('content'),{
      timeout: 60
    });
  } else {
    console.log("Faye server is off!");
  }

});

