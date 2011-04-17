$(function(){
  App.Views.Stats = Backbone.View.extend({
    tagName:  "div",

    events: {
      //"click .views": "onTabChange",
    },

    initialize: function() {
      _.bindAll(this, 'render');
      this.render();
    },

    render: function() {
      $(this.el).empty();
      $(this.el).append("<div class='please_wait'>Wczytywanie danych...</div>");
      return this;
    },
  });
});

