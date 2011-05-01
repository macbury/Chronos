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
    window.error("Błąd połączenia!!!", "Nie można się połączyć z serwerem! Odśwież stronę lub spróbuj później.", function(){
      window.location.reload();
    });
  }
  
  for(var controller_name in App.Controllers) {
    window[controller_name] = new App.Controllers[controller_name]();
  }
  
  window.menuView = new App.Views.Menu();
  
  App.Router.run();
});

