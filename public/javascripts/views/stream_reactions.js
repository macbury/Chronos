$(function(){
  App.Views.Reactions = Backbone.View.extend({
    tagName:  "ul",

    events: {
      //"click .views": "onTabChange",
    },

    initialize: function() {
      _.bindAll(this, 'render', 'addOne');
      this.model.links.bind('refresh', this.render);
      //this.model.links.bind('change', this.render);
      this.render();
    },

    addOne: function(link) {
      var linkView = new App.Views.Link({model: link});
      $(linkView.render().el).appendTo(this.el);
    },

    render: function() {
      $(this.el).empty();
      $(this.el).addClass("list");
      $(this.el).append("<li class='please_wait'>Wczytywanie danych...</li>");
      return this;
    },
  });
});

