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
  client = new Faye.Client($('meta[name=notifications_server]').attr('content'),{
    timeout: 60
  });
  DashboardController.init();
  
  $(".toggle").live("click", function(){
    $($(this).attr("href")).toggle("blind");
    return false;
  });
});
