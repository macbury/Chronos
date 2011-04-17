$(function(){
  App.Views.Dashboard = Backbone.View.extend({
    el: "#workspace",
    streamListView: null,

    events: {
      "click .actions .new_status": "newStatus",
      "click .actions .new_event": "newEvent",
    },

    newStatus: function() {
      var statusView = new App.Views.NewStatus({ model: new App.Models.Status() });
      statusView.render();

      return false;
    },

    newEvent: function() {
      var eventView = new App.Views.NewEvent({ model: new App.Models.Status() });
      eventView.render();

      return false;
    },

    initialize: function(){
      _.bindAll(this, 'render', 'newStatus', 'newEvent');

      App.Storage.Streams = new App.Collections.Stream();
      App.Storage.Streams.bind("refresh", this.render);

      this.streamListView = new App.Views.StreamList();
      App.Storage.Streams.fetch();
    },

    render: function() {
      $(this.el).find("#stream").html(this.streamListView.render().el);
      return this;
    },
  });
});

