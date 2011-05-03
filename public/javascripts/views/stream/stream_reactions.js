$(function(){
  App.Views.Reactions = Backbone.View.extend({
    tagName:  "ul",

    events: {
      //"click .views": "onTabChange",
    },
    

    initialize: function() {
      _.bindAll(this, 'render', 'addOne');
      this.model.reactions.bind('refresh', this.render);
      //this.model.links.bind('change', this.render);
      this.render();
    },

    addOne: function(reaction) {
      var reactionView = new App.Views.Reaction({model: reaction});
      $(reactionView.render().el).appendTo(this.el);
    },

    render: function() {
      $(this.el).empty();
      $(this.el).addClass("list");
      
      if(this.model.reactions.length == 0) {
        $(this.el).append("<li class='please_wait'>Brak reakcji...</li>");
      } else {
        this.model.reactions.each(this.addOne);
      }
      return this;
    },
  });
});

