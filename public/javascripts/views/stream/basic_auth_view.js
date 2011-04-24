$(function(){
  App.Views.BasicAuth = Backbone.View.extend({
    tagName:  "div",
    
    events: {
      "click .login_box .submit": "login",
      "click .button.close": "remove"
    },
    
    initialize: function() {
      _.bindAll(this, 'render', 'remove', 'add', "login");
    },
    
    login: function(){
      this.$('.login_box').hide();
      this.$('#auth_process').show();
      
      return false;
    },
    
    add: function() {

    },

    remove: function() {
      $(this.el).dialog("close");
    },

    render: function() {
      var self = this;
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.basic_auth, { }));
      $(this.el).dialog({
        title: "Logowanie do serwisu:",
        autoOpen: false,
        show: "fade",
        hide: "fade",
        width: 480,
        resizable: false,
        modal: true,
      });

      $(this.el).dialog("open");
      return this;
    },
  });
});

