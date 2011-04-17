$(function(){
  App.Views.Dashboard = Backbone.View.extend({
    el: "#workspace",
    streamListView: null,

    events: {
      "click .actions .new_status": "newStatus",
    },

    newStatus: function() {
      var statusView = new App.Views.NewStatus({ model: new App.Models.Status() });
      statusView.render();

      return false;
    },

    initialize: function(){
      _.bindAll(this, 'render', 'newStatus');
      this.streamListView = new App.Views.StreamList();
    },

    render: function() {
      $(this.el).find("#stream").html(this.streamListView.render().el);
      return this;
    },
  });
});

