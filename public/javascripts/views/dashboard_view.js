$(function(){
  App.Views.Dashboard = Backbone.View.extend({
    el: "body",
    streamListView: null,
    detailsView: null,
    selectedStream: null,
    events: {
      "click .menu .status": "newStatus",
      "click .menu .event": "newEvent",
    },
    
    newStatus: function() {
      var statusView = new App.Views.NewStatus({ model: new App.Models.Status() });
      statusView.render();

      return false;
    },

    newEvent: function() {
      var eventView = new App.Views.NewEvent({ model: new App.Models.Event() });
      eventView.render();

      return false;
    },

    initialize: function(){
      _.bindAll(this, 'render', 'newStatus', 'newEvent');
      App.Storage.Streams.bind("refresh", this.render);
      var self = this;
      
      this.streamListView = new App.Views.StreamList();
      this.detailsView = new App.Views.StreamDetails();
    },

    render: function() {
      $(this.el).find("#stream").html(this.streamListView.render().el);
      $(this.el).find("#details").html(this.detailsView.render().el);
      return this;
    },
  });
});

