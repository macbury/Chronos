$(function(){
  App.Views.Notifications = Backbone.View.extend({
    el: ".dropdown_menu.notifications",

    events: {
      'click a': "read"
    },
    
    read: function(e) {
      if (e.currentTarget) {
        var a = $(e.currentTarget);
        var model = App.Storage.Reactions.get(a.attr("data-id"));
      } else {
        var model = App.Storage.Reactions.get(e["id"]);
      }
      
      model.url = "/reactions/"+model.get("id");
      model.save({
        "unread": false
      });

    },
    
    initialize: function(){
      _.bindAll(this, 'render', 'add', "read");
      var self = this;
      App.Storage.Reactions = new App.Collections.Reactions();
      App.Storage.Reactions.url = "/reactions";
      App.Storage.Reactions.bind("refresh", this.render);
      App.Storage.Reactions.bind("add", this.render);
      App.Storage.Reactions.bind("change", this.render);
      App.Storage.Reactions.fetch();
      
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications", function(data) {
        var data = jQuery.parseJSON(data);
        App.Storage.Reactions.add(data);
        $.notice({ 
          title: "Chronos",
          description: data["message"],
          callback: function() {
            self.read(data["id"]);
          }
        });
      });
    },
    
    add: function(reaction) {
    
    },
    
    render: function() {
      var self = this;
      this.$('.list').empty();
      if(App.Storage.Reactions.unreaded().length > 0) {
        this.$('.list').html(Haml.render(JST.notifications, { locals: { notifications: App.Storage.Reactions.unreaded() } }));
      } else {
        this.$('.list').html("<p class='empty'>Brak notyfikacji</p>");
      }
      
      return this;
    }
  });
});

