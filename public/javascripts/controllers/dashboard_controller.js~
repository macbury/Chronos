$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    view: null,
    
    routes: {
      "dashboard": "index",
    },

    index: function() {
      console.log("index");
      var self = this;
      var dashboardView = new App.Views.Dashboard();
      App.Storage.Streams.bind("refresh", function(){
        dashboardView.render();
      });
      dashboardView.render();
    },

    initialize: function() {
      console.log("Dashboard initialize");
      App.Storage.Streams = new App.Collections.Stream();
      App.Storage.Streams.fetch();
      window.location.hash = "#dashboard";
    }
  });
})
