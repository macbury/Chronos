App.Controllers.Dashboard = Backbone.Controller.extend({
  streams: null,
  
  routes: {
    "#": "index",
  },

  index: function() {
    console.log("index");
  },

  initialize: function() {
    console.log("Dashboard initialize");
    this.streams = new App.Collections.Stream();
    this.streams.fetch();
  }
});
