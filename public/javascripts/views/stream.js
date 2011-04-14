$(function(){
  App.Views.Stream = Backbone.View.extend({
    tagName:  "li",
    
    events: {
      "click .views": "onTabChange",
    },
    
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      this.model.view = this;
      
    },
    
    onTabChange: function(e){
      var a = $(e.target);
      var links = $(this.el).find(".views").find("a");
      links.removeClass("selected");
      a.addClass("selected");
      
      return false;
    },
    
    render: function() {
      $(this.el).addClass("update")
                .attr("id", "stream_"+this.model.get("id"))
                .html(Haml.render(JST.status, { locals: {status: this.model} }));
      $(this.el).find("abbr").attr("title", this.model.get("created_at"));
      $(this.el).find("abbr").timeago();
      
      return this;
    },
  });
});
