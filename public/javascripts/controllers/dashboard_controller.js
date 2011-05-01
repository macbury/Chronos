$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    dashboardView: null,
    
    preload: function() {
      App.Storage.Streams.fetchOnce();
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
      App.Storage.Streams.comparator = function(stream) {
        var d = new Date(stream.get("created_at"));
        return d * -1;
      };
      App.Router.match("/streams/:id", {
        as: "stream",
        callback: this.show
      });
      
      App.Router.root(this.index);
    }
  });
})

