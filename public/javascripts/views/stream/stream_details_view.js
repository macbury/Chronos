$(function(){
  App.Views.StreamDetails = Backbone.View.extend({
    tagName: "div",
    loading: false,
    template: null,
    
    selectStream: function() {
      this.model = this.streamDetailsCache.get(params['id']);
      var self = this;
      if(this.model == null) {
        this.model = new App.Models.Stream({ id: params['id'] });
        this.loading = true;
        this.model.fetch({
          success: function(){
            self.streamDetailsCache.add(self.model);
            self.loading = false;
            self.render();
          },
          error: function() {
            self.model = null;
            self.loading = false;
            self.render();
          }
        });
      }
      this.model.bind('change', this.render);
      this.render();
    },
    
    initialize: function(){
      _.bindAll(this, 'render', 'selectStream', 'resize');
      this.streamDetailsCache = new App.Collections.Stream();
      this.template = JST.stream_details;
      
      this.render();
    },
    
    streamTemplate: function() {
      var key = "stream_"+this.model.get("streamable_type").toLowerCase();
      return JST[key];
    },
    
    resize: function() {
      this.$('.block, .empty').height($(window).height() - 80);
      this.$('.details > .content').height(this.$('.details').height() - this.$('.details > .header').height() - 17);
    },
    
    render: function() {
      $(this.el).empty();
      if (this.loading){
        $(this.el).append("<div class='empty loading'></div> ");
      } else if(this.model == null) {
        $(this.el).append("<div class='empty'>Nic nie zaznaczono...<div>");
      } else {
        var partial = Haml.render(this.streamTemplate(), { locals: {stream: this.model} });
        $(this.el).html(Haml.render(this.template, { locals: {stream: this.model, stream_partial: partial} }));
        $(this.el).find("abbr").attr("title", this.model.get("created_at"));
        $(this.el).find("abbr").timeago();
      }
      this.resize();
      return this;
    },
  });
});

