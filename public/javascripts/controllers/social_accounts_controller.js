$(function(){
  App.Controllers.SocialAccounts = Backbone.Controller.extend({
    social_accounts_view: null,
    
    view: function() {
      if(this.social_accounts_view == null){
        this.social_accounts_view = new App.Views.SocialAccounts();
      }
      return this.social_accounts_view ;
    },
    
    show: function() {
      var social_account = App.Storage.SocialAccounts.get(params['id'])
      
      if(social_account) {
        var view = new App.Views.SocialAccount({ model: social_account });
        view.render();
      } else {
        redirect_to(social_accounts_path());
      }
    },
    
    index: function() {
      //this.preload();
      this.view().render();
    },
    
    basic_auth: function() {
    
    },
    
    initialize: function() {
      _.bindAll(this, 'index', 'view', 'show', "basic_auth");
      App.Storage.SocialAccounts = new App.Collections.SocialAccounts();
      
      App.Router.match("/accounts", {
        as: "social_accounts",
        callback: this.index
      });
      
      App.Router.match("/accounts/:id", {
        as: "social_account",
        callback: this.show
      });
      
      App.Router.match("/accounts/auth/:provider", {
        as: "basic_auth",
        callback: this.basic_auth
      });
      
      App.Router.match("/accounts/facebook", {
        as: "facebook_social_account",
        callback: function() {}
      });
    }
  });
})

