$(function(){
  App.Controllers.SocialAccounts = Backbone.Controller.extend({
    
    view: function() {
      if(this.dashboardView == null){
        this.dashboardView = new App.Views.Dashboard();
      }
      return this.dashboardView;
    },
    
    show: function() {
      this.preload();
      this.view().detailsView.selectStream();
      this.view().streamListView.selectStream(this.view().detailsView.model);
    },
    
    index: function() {
      //this.preload();
      //this.view().render();
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
    }
  });
})

