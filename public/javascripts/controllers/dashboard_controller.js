$(function(){
  App.Controllers.Dashboard = Backbone.Controller.extend({
    view: null,

    routes: {
      "/dashboard": "index",
    },

    index: function() {
      var self = this;
      var dashboardView = new App.Views.Dashboard();
      App.Storage.Streams.bind("refresh", function(){
        dashboardView.render();
      });
    },

    initialize: function() {
      App.Storage.Streams = new App.Collections.Stream();
      App.Storage.Streams.fetch();
      if(window.location.hash == "")
        window.location.hash = "#/dashboard";
    }
  });
})

