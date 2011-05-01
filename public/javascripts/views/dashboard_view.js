$(function(){
  App.Views.Dashboard = Backbone.View.extend({
    el: "body",
    streamListView: null,
    detailsView: null,
    selectedStream: null,


    initialize: function(){
      _.bindAll(this, 'render');
      App.Storage.Streams.bind("refresh", this.render);
      var self = this;
      
      this.streamListView = new App.Views.StreamList();
      this.detailsView = new App.Views.StreamDetails();
    },

    render: function() {
      this.$("#workspace").html(Haml.render(JST.dashboard, { locals: {} }));
      $(this.el).find("#stream").html(this.streamListView.render().el);
      $(this.el).find("#details").html(this.detailsView.render().el);

      return this;
    },
  });
});

