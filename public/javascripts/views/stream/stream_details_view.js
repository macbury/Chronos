$(function(){
  App.Views.StreamDetails = Backbone.View.extend({
    tagName: "div",
    loading: false,
    template: null,
    tab: "links",
    
    selectStream: function() {
      this.linksView = null;
      this.reactionsView = null;
      this.statsView = null;
      this.tab = "links";
      if(_.include(["links", "reactions", "stats"], params['tab']))
        this.tab = params["tab"];
        
      this.model = this.streamDetailsCache.get(params['id']);
      var self = this;
      
      if(this.model == null) {
        this.model = new App.Models.Stream({ id: params['id'] });
        this.loading = true;
        this.model.fetch({
          success: function(){
            try {
              self.streamDetailsCache.add(self.model);
            } catch (exception) {
              console.log(exception);
            }
            
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
      _.bindAll(this, 'render', 'selectStream', 'resize', 'tabView');
      var self = this;
      this.streamDetailsCache = new App.Collections.Stream();
      this.template = JST.stream_details;
      
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications/links", function(data) {
        var data = jQuery.parseJSON(data);
        
        var streamRecord = self.streamDetailsCache.get(data["stream_id"]);
        if(streamRecord != null) {
          if (streamRecord.links.length == 0) {
            streamRecord.links.download();
          } else {
            streamRecord.links.get(data["id"]).set(data);
          }
        }
      });
      this.render();
    },
    
    streamTemplate: function() {
      var key = "stream_"+this.model.get("streamable_type").toLowerCase();
      return JST[key];
    },
    
    tabView: function() {
      var view = null;

      if(this.tab == "links") {
        if(this.linksView == null){
          this.linksView = new App.Views.Links({model: this.model});
          this.model.links.fetch();
        }
        view = this.linksView;
      } else if(this.tab == "reactions") {
        if(this.reactionsView == null){
          this.reactionsView = new App.Views.Reactions({model: this.model});
        }
        view = this.reactionsView;
      } else if(this.tab == "stats") {
        if(this.statsView == null){
          this.statsView = new App.Views.Stats({model: this.model});
        }
        view = this.statsView;
      }
      return view;
    },
    
    resize: function() {
      this.$('.block, .empty').height($(window).height() - 80);
      this.$('.details > .scroller').height(this.$('.details').height() - this.$('.details > .header').height() - 17);
    },
    
    render: function() {
      $(this.el).empty();
      if (this.loading){
        $(this.el).append("<div class='empty loading'></div> ");
      } else if(this.model == null) {
        $(this.el).append("<div class='empty'>Nic nie zaznaczono...<div>");
      } else {

        var partial = Haml.render(this.streamTemplate(), { locals: {stream: this.model} });
        $(this.el).html(Haml.render(this.template, { locals: {stream: this.model, stream_partial: partial, tab: this.tab} }));
        $(this.el).find("abbr").attr("title", this.model.get("created_at"));
        $(this.el).find("abbr").timeago();
        
        this.$(".scroller").empty().append(this.tabView().el);
      }
      this.resize();
      return this;
    },
  });
});

