$(function(){
  App.Views.Notifications = Backbone.View.extend({
    el: ".dropdown_menu.notifications",

    events: {

    },

    initialize: function(){
      _.bindAll(this, 'render', 'add');
      var self = this;
      this.reactions = new App.Collections.Reactions();
      this.reactions.url = "/reactions";
      this.reactions.bind("refresh", this.render);
      this.reactions.bind("add", this.render);
      
      this.reactions.fetch();
      
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications", function(data) {
        var data = jQuery.parseJSON(data);
        self.reactions.add(data);
        $.notice({ 
          title: "Chronos",
          description: data["message"]
        });
      });
    },
    
    add: function(reaction) {
    
    },
    
    render: function() {
      var self = this;
      this.$('.list').empty();
      if(this.reactions.length > 0) {
        this.$('.list').html(Haml.render(JST.notifications, { locals: { notifications: this.reactions.models } }));
      } else {
        this.$('.list').html("<p class='empty'>Brak notyfikacji</p>");
      }
      
      return this;
    }
  });
});

