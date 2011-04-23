$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    dashboardView: null,
    
    view: function() {
      if(this.dashboardView == null){
        this.dashboardView = new App.Views.Dashboard();
      }
      return this.dashboardView;
    },
    
    show: function() {
      this.view().detailsView.selectStream();
      this.view().streamListView.selectStream(this.view().detailsView.model);
    },
    
    index: function() {
      this.view().render();
    },

    initialize: function() {
      _.bindAll(this, 'index', 'view', 'show');
      App.Storage.Streams = new App.Collections.Stream();
      App.Storage.Streams.fetch();
      
      App.Router.match("/streams/:id", {
        as: "stream",
        callback: this.show
      });
      
      App.Router.root(this.index);
      
      App.Router.run();
    }
  });
})

