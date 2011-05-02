$(function(){
  App.Views.Menu = Backbone.View.extend({
    el: ".menu",

    events: {
      "click .status": "newStatus",
      "click .event": "newEvent",
      //"click .photo": "newPhoto",
      "click #notification_permission": "changeNotificationPermission"
    },
    
    newPhoto: function() {
      var photosView = new App.Views.UploadPhoto();
      photosView.render();
      return false;
    },
    
    newStatus: function() {
      var statusView = new App.Views.NewStatus({ model: new App.Models.Status() });
      statusView.render();

      return false;
    },

    newEvent: function() {
      var eventView = new App.Views.NewEvent({ model: new App.Models.Event() });
      eventView.render();

      return false;
    },

    initialize: function(){
      _.bindAll(this, 'render', 'newStatus', 'newEvent', 'newPhoto', 'changeNotificationPermission');
      var photoUpload = new App.Views.UploadPhoto();
      this.render();
    },

    changeNotificationPermission: function() {
      window.webkitNotifications.requestPermission(function(){
        $.notice({ 
          title: "Chronos",
          description: "Będziesz teraz dostawał powiadomienia na pulpicie!"
        });
      });
    },

    render: function() {
      var self = this;
      
      
      
      this.$('.dropdown').click(function(){
        var selected = $(this).hasClass("selected");
        self.$('.dropdown').removeClass("selected");
        
        self.$('.dropdown_menu').hide();
        if(!selected) {
          $(this).addClass("selected");
          $(this).parents("li").find(".dropdown_menu").show();
        } else {
          $(this).removeClass("selected");
        }
        return false;
      });
      
      this.$('.dropdown_menu a').click(function(){
        $(this).parents("li").find('.dropdown').removeClass("selected");
        $(this).parents('.dropdown_menu').hide();
      });
      
      var html5Notification = (window["webkitNotifications"] != null);
  
      if(html5Notification) {
        if(window.webkitNotifications.checkPermission() > 0) {
          this.$('#notification_permission').removeAttr("checked");
        } else {
          this.$('#notification_permission').attr("checked", "checked");
        }
        
      }
      
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications", function(data) {
        var data = jQuery.parseJSON(data);
        console.log(data);
        
        $.notice({ 
          title: "Chronos",
          description: data["message"]
        });
      });
      return this;
    },
  });
});

