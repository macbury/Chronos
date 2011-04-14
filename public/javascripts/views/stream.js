$(function(){
  App.Views.Stream = Backbone.View.extend({
    tagName:  "li",
    
    initialize: function() {
      this.model.bind('change', this.render);
      this.model.view = this;
    },
    
    render: function() {
      $(this.el).addClass("update")
                .attr("id", "stream_"+this.model.get("id"))
                .html(Haml.render(JST.status, { locals: {status: this.model} }));
      $(this.el).find("abbr").attr("title", this.model.get("created_at"));
      $(this.el).find("abbr").timeago();
      
      $(this.el)
      
      $(this.el).find('.views a').live("click", function(){
        var links = $(this).parents(".views").find("a");
        var update_id = $(this).parents(".views").attr("data-id");
        links.removeClass("selected");
        
        $(this).addClass("selected");
        return false;
      });
      return this;
    },
  });
});
