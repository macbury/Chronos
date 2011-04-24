$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    dashboardView: null,
    
    preload: function() {
      if(App.Storage.Streams.length == 0) {
        App.Storage.Streams.fetch();
      }
    },
    
    view: function() {
      if(this.dashboardView == null){
        this.dashboardView = new App.Views.Dashboard();
      }
      return this.dashboardView;
    },
    
    show: function() {
      this.preload();
      this.view().render();
      this.view().detailsView.selectStream();
      this.view().streamListView.selectStream(this.view().detailsView.model);
    },
    
    index: function() {
      this.preload();
      this.view().render();
    },

    initialize: function() {
      _.bindAll(this, 'index', 'view', 'show', 'preload');
      App.Storage.Streams = new App.Collections.Stream();
      App.Storage.comparator = function(stream) {
        return new Date(stream.get("created_at"));
      };
      App.Router.match("/streams/:id", {
        as: "stream",
        callback: this.show
      });
      
      App.Router.root(this.index);
    }
  });
})

