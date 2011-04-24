$(function(){
  App.Views.StreamList = Backbone.View.extend({
    tagName: "ul",
    selectedStream: null,
    
    initialize: function(){
      _.bindAll(this, 'addOne', 'addNew', 'render', 'selectStream');
      App.Storage.Streams.bind("add", this.addNew);
    },

    addNew: function(stream) {
      var streamView = new App.Views.Stream({model: stream});
      $(this.el).prepend(streamView.render().el);
      $(this.el).find(".update").removeClass("alt");
      $(this.el).find(".update:even").addClass("alt");
      this.$(".empty").remove();
    },

    addOne: function(stream){
      var streamView = new App.Views.Stream({model: stream});
      var li = $(streamView.render().el);
      
      if(this.selectedStream && this.selectedStream.get("id") == stream.get("id")) {
        li.addClass("selected");
      }
      
      $(this.el).append(li);
    },
    
    selectStream: function(model) {
      this.selectedStream = model;
      this.$(".update").removeClass("selected");
      this.$("#stream_"+model.get("id")).addClass("selected");
    },
    
    render: function() {
      $(this.el).empty();
      if(App.Storage.Streams == null){
        $(this.el).append("<li class='empty'>Prosze czekać... Trwa wczytywanie danych...</li>");
      } else if(App.Storage.Streams.length == 0) {
        $(this.el).append("<li class='empty'>Aktualnie nie masz dodanych żadnych wpisów!</li>");
      } else {
        App.Storage.Streams.each(this.addOne);
      }
      $(this.el).find(".update").removeClass("alt");
      $(this.el).find(".update:even").addClass("alt");
      return this;
    },
  });
});

