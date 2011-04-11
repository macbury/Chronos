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
  client = new Faye.Client('http://0.0.0.0:9292/realtime',{
    timeout: 60
  });
  DashboardController.init();
});
