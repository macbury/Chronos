$(function(){
  App.Views.Dashboard = Backbone.View.extend({
    tagName:  "ul",
    streams: null,
    
    initialize: function(){
      _.bindAll(this, 'addOne', 'render');
    },
    
    addOne: function(stream){
      var streamView = new App.Views.Stream({model: stream});
      $(this.el).append(streamView.render().el);
    },
    
    render: function() {
      $(this.el).addClass("list");
      $(this.el).empty();
      if(this.streams == null){
        $(this.el).append("<li class='loading'>Prosze czekać... Trwa wczytywanie danych...</li>");
      } else if(this.streams.lenght == 0) {
        $(this.el).append("<li>Aktualnie nie masz dodanych żadnych wpisów!</li>");
      } else {
        this.streams.each(this.addOne);
      }
      
      $(this.el).appendTo("#workspace");
    },
  });
});
