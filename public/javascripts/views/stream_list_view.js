$(function(){
  App.Views.StreamList = Backbone.View.extend({
    tagName: "ul",
    selectedStream: null,
    currentPage: 1,
    
    events: {
      'click .button': 'nextPage'
    },
    
    initialize: function(){
      _.bindAll(this, 'addOne', 'addNew', 'render', 'selectStream', 'nextPage');
      //App.Storage.Streams.bind("add", this.addNew);
      App.Storage.Streams.bind("refresh", this.render);
      App.Storage.Streams.bind("add", this.render);
    },
    
    nextPage: function() {
      this.currentPage++;
      $.getJSON("/streams?page="+this.currentPage, function(data){
        App.Storage.Streams.add(data);
      });
      console.log(this.currentPage);
      return false;
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
        $(this.el).find(".update").removeClass("alt");
        $(this.el).find(".update:even").addClass("alt");
        
        if(App.Storage.Streams.length >= 10) {
	    //$(this.el).append("<li class='loading'><button class='button load_more'>Wczytaj więcej</button></li>");
        }
        
        $(this.el).find(".load_more").click(this.nextPage);
      }

      return this;
    },
  });
});

