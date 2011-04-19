$(function(){
  App.Views.StreamList = Backbone.View.extend({
    tagName: "ul",

    initialize: function(){
      _.bindAll(this, 'addOne', 'addNew', 'render');
      App.Storage.Streams.bind("add", this.addNew)
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications/links", function(data) {
        var data = jQuery.parseJSON(data);
        var streamRecord = App.Storage.Streams.get(data["stream_id"]);
        if(streamRecord != null) {
          if (streamRecord.links.length == 0) {
            streamRecord.links.download();
          } else {
            streamRecord.links.get(data["id"]).set(data);
          }
        }
      });
    },

    addNew: function(stream) {
      var streamView = new App.Views.Stream({model: stream});
      $(this.el).prepend(streamView.render().el);
      $(this.el).find(".update").removeClass("alt");
      $(this.el).find(".update:even").addClass("alt");
    },

    addOne: function(stream){
      var streamView = new App.Views.Stream({model: stream});
      $(this.el).append(streamView.render().el);
    },

    render: function() {
      $(this.el).addClass("list");
      $(this.el).empty();
      if(App.Storage.Streams == null){
        $(this.el).append("<li class='loading'>Prosze czekać... Trwa wczytywanie danych...</li>");
      } else if(App.Storage.Streams.length == 0) {
        $(this.el).append("<li>Aktualnie nie masz dodanych żadnych wpisów!</li>");
      } else {
        App.Storage.Streams.each(this.addOne);
      }
      $(this.el).find(".update").removeClass("alt");
      $(this.el).find(".update:even").addClass("alt");
      return this;
    },
  });
});

