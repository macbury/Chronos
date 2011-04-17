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
      if(this.model.links.length > 0) {
        $(this.el).addClass("links").removeClass("list");
        this.model.links.each(this.addOne);
        $(this.el).find("li:even").addClass("alt");
      } else {
        $(this.el).addClass("list");
        $(this.el).html("<li class='please_wait'>Wczytywanie danych...</li>");
      }
      return this;
    },
  });
});

