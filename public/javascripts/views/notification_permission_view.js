$(function(){
  App.Views.NotificationPermission = Backbone.View.extend({
    tagName: "div",

    initialize: function(){
      _.bindAll(this, 'render');
      var html5Notification = (window["webkitNotifications"] != null);
  
      if(html5Notification && window.webkitNotifications.checkPermission() > 0) {
        this.render();
      }
    },

    render: function() {
      var self = this;
      
      return this;
    },
  });
});

