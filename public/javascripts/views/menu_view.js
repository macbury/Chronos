$(function(){
  App.Views.Menu = Backbone.View.extend({
    el: ".menu",

    events: {
      "click .status": "newStatus",
      "click .event": "newEvent",
      "click .photo": "newPhoto",
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
      _.bindAll(this, 'render', 'newStatus', 'newEvent', 'newPhoto');
      this.render();
    },

    render: function() {
      var self = this;
      this.$('.dropdown').click(function(){
        $(this).addClass("selected");
        self.$('.dropdown_menu').hide();
        $(this).parents("li").find(".dropdown_menu").show();
        return false;
      });
      
      this.$('.dropdown_menu a').click(function(){
        $(this).parents("li").find('.dropdown').removeClass("selected");
        $(this).parents('.dropdown_menu').hide();
      });
      return this;
    },
  });
});

