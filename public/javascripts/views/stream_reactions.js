$(function(){
  App.Views.Links = Backbone.View.extend({
    tagName:  "ul",
    
    events: {
      //"click .views": "onTabChange",
    },
    
    initialize: function() {
      _.bindAll(this, 'render', 'addOne');
      this.model.links.bind('refresh', this.render);
      this.render();
    },
    
    addOne: function(link) {
      var linkView = new App.Views.Link({model: link});
      $(linkView.render().el).appendTo(this.el);
    },
    
    render: function() {
      $(this.el).empty();
      $(this.el).addClass("links");
      if(this.model.links.length > 0) {
        this.model.links.each(this.addOne);
        $(this.el).find("li:even").addClass("alt");
      } else {
        $(this.el).html("<li>Wczytywanie danych...</li>");
      }
      return this;
    },
  });
});
