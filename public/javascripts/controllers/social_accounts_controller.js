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
      this.preload();
      this.view().detailsView.selectStream();
      this.view().streamListView.selectStream(this.view().detailsView.model);
    },
    
    index: function() {
      //this.preload();
      this.view().render();
    },

    initialize: function() {
      _.bindAll(this, 'index', 'view', 'show');
      App.Storage.SocialAccounts = new App.Collections.SocialAccounts();
      
      App.Router.match("/accounts", {
        as: "social_accounts",
        callback: this.index
      });
      
      App.Router.match("/accounts/:id", {
        as: "social_account",
        callback: this.index
      });
      
      App.Router.match("/accounts/facebook", {
        as: "facebook_social_account",
        callback: function() {}
      });
    }
  });
})

