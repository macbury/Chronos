$(function(){
  App.Views.Link = Backbone.View.extend({
    tagName:  "li",
    
    events: {
      //"click .views": "onTabChange",
    },
    
    initialize: function() {
      _.bindAll(this, 'render', "refresh");
      this.model.bind('refresh', this.render);
      this.model.bind('change', this.refresh);
    },
    
    refresh: function() {
      $(this.el).html(Haml.render(JST.stream_links, { locals: {link: this.model} }));
    },
    
    render: function() {
      $(this.el).html(Haml.render(JST.stream_links, { locals: {link: this.model} }));
      $(this.el).addClass(this.model.get("social_account").type_name).attr("id","stream_link_"+this.model.get("id"));
      return this;
    },
  });
});
