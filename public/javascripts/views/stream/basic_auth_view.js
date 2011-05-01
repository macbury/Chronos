$(function(){
  App.Views.BasicAuth = Backbone.View.extend({
    tagName:  "div",
    provider: null,
    
    events: {
      "click .login_box .submit": "login",
      "click .button.close": "remove"
    },
    
    initialize: function() {
      _.bindAll(this, 'render', 'remove', 'add', "login", "update");
    },
    
    update: function(data){
      this.$('.progress_status img').hide();
      this.$('.progressbar').show();
      this.$('.progress').animate({
        width: data.progress + "%"
      });
      
      if(data["status"]) {
        this.$("#status_message").text(data["status"]);
      } else if(data["error"]) {
        this.$("#status_message").text(data["error"]);
        this.$("#status_message").addClass("error");
        this.$(".button.close").show();
      } else if(data["success"]) {
        this.$("#status_message").text(data["success"]);
        this.$(".button.close").show();
        App.Storage.SocialAccounts.fetch();
      }
    },
    
    login: function(){
      var self = this;
      this.$('.login_box').hide();
      this.$('#auth_process').show();
      
      $.ajax({
        url: "/auth/"+this.provider,
        type: "POST",
        data: this.$("form").serialize(),
        dataType: "JSON",
        success: function(resp){
          var resp = jQuery.parseJSON(resp);
          self.model = new App.Models.SocialAccount(resp);
          App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/"+resp["id"]+"/auth", function(data) {
            var data = jQuery.parseJSON(data);
            self.update(data);
          });
        }
      })
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

