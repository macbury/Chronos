var AuthController = {
  init: function (type) {
    var div = $('#auth_process');
    if(div.size() == 0) {
      return false;
    }
    
    var self = this;
    client.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/"+div.attr("data-id")+"/auth", function(data) {
      var data = jQuery.parseJSON(data);
      self.process(data);
    });
  },
  
  process: function(data) {
    if(data["status"]) {
      $("#status_message").text(data["status"]);
    } else if(data["error"]) {
      $("#status_message").text(data["error"]);
    } else if(data["success"]) {
      $("#status_success").text(data["success"]);
      setTimeout(function(){
        window.location.href = $('#auth_process').attr("data-redirect_to");
      }, 5000);
    }
  }
}
