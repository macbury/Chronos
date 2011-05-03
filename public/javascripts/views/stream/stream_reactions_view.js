$(function(){
  App.Views.Reaction = Backbone.View.extend({
    tagName:  "li",
    
    events: {
      //"click .views": "onTabChange",
    },
    
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('refresh', this.render);
      this.model.bind('change', this.render);
    },
    
    render: function() {
      $(this.el).html(Haml.render(JST.stream_reaction, { locals: {reaction: this.model} }));
      $(this.el).addClass(this.model.get("social_account").type_name).attr("id","stream_link_"+this.model.get("id"));
      
      return this;
    },
  });
});
