$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    streams: null,
    view: null,
    
    routes: {
      "dashboard": "index",
    },

    index: function() {
      console.log("index");
      var self = this;
      var dashboardView = new App.Views.Dashboard();
      this.streams.bind("refresh", function(){
        dashboardView.streams = self.streams;
        dashboardView.render();
      });
      dashboardView.render();
    },

    initialize: function() {
      console.log("Dashboard initialize");
      this.streams = new App.Collections.Stream();
      this.streams.fetch();
      window.location.hash = "#dashboard";
    }
  });
})
