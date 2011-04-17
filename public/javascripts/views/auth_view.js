$(function(){
  App.Views.Auth = Backbone.View.extend({
    el: "#auth_process",

    events: {

    },

    initialize: function(){
      var self = this;
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/"+$(this.el).attr("data-id")+"/auth", function(data) {
        var data = jQuery.parseJSON(data);
        self.update(data);
      });
    },

    update: function(data) {
      $('.progress_status img', this.el).hide();
      $('.progressbar', this.el).show();
      var redirect_to = $(this.el).attr("data-redirect_to");
      $('.progress', this.el).animate({
        width: data.progress + "%"
      });
      if(data["status"]) {
        $("#status_message", this.el).text(data["status"]);
      } else if(data["error"]) {
        $("#status_message", this.el).text(data["error"]);
        $("#status_message", this.el).addClass("error");
        setTimeout(function(){
          window.location.href = redirect_to;
        }, 5000);
      } else if(data["success"]) {
        $("#status_message", this.el).text(data["success"]);
        setTimeout(function(){
          window.location.href = redirect_to;
        }, 5000);
      }
    }
  });
});

