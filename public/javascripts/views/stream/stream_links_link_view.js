$(function(){
  App.Views.Link = Backbone.View.extend({
    tagName:  "li",
    
    events: {
      //"click .views": "onTabChange",
    },
    
    initialize: function() {
      _.bindAll(this, 'render', "refresh", "canvas", "render_progress");
      this.model.bind('refresh', this.render);
      this.model.bind('change', this.refresh);
    },
    
    refresh: function() {
      $(this.el).html(Haml.render(JST.stream_links, { locals: {link: this.model} }));
      this.render_progress();
    },
    
    canvas: function() {
      return this.$('canvas')[0].getContext('2d');
    },
    
    render_progress: function() {
      var progress = this.model.get("progress");
      if(progress > 0) {
        progress = progress / 100;
      }
      
      var ctx = this.canvas();
      ctx.save();
      ctx.clearRect(0,0,32,32);
      ctx.translate(16,16);
      ctx.scale(2,2);

      ctx.rotate(-Math.PI/2);
      ctx.lineWidth = 2;
      ctx.lineCap = "square";
      
      ctx.save();
      ctx.strokeStyle = "#D7D7D7";
      ctx.beginPath();
      
      ctx.arc(0,0, 4,0,progress*(Math.PI*2),false);
      
      ctx.stroke();
      ctx.restore();
    },
    
    render: function() {
      $(this.el).html(Haml.render(JST.stream_links, { locals: {link: this.model} }));
      $(this.el).addClass(this.model.get("social_account").type_name).attr("id","stream_link_"+this.model.get("id"));
      this.render_progress();
      
      return this;
    },
  });
});
