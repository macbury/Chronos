$(function(){
  App.Views.Stream = Backbone.View.extend({
    tagName:  "li",
    linksView: null,
    reactionsView: null,
    statsView: null,

    events: {
      "click .views": "onTabChange",
      "click .urls": "selectedLinks",
      "click .reactions": "selectedReactions",
      "click .stats": "selectedStats"
    },

    initialize: function() {
      _.bindAll(this, 'render', 'selectedLinks', "refresh", "template");
      this.model.bind('change', this.refresh);
      this.model.links.bind('change', this.refresh);
      this.model.links.bind('refresh', this.refresh);
      this.model.view = this;
    },

    refresh: function() {
      if(this.el == null) {
        this.render();
      }

      if(this.model.links.done().length == this.model.links.length) {
        $(this.el).find('.progressbar').fadeOut();
      } else {
        $(this.el).find('.progressbar').fadeIn();
      }

      $(this.el).find('.progressbar .progress').animate({
        width: this.model.progress() + "%"
      });
    },

    selectedLinks: function() {
      if(this.linksView == null){
        this.linksView = new App.Views.Links({model: this.model});
        this.model.links.fetch();
      }

      $(this.el).find(".tab").empty().append(this.linksView.el).show();
    },

    selectedReactions: function() {
      if(this.reactionsView == null){
        this.reactionsView = new App.Views.Reactions({model: this.model});
        //this.model.links.fetch();
      }

      $(this.el).find(".tab").empty().append(this.reactionsView.el).show();
    },

    selectedStats: function() {
      if(this.statsView == null){
        this.statsView = new App.Views.Stats({model: this.model});
        //this.model.links.fetch();
      }

      $(this.el).find(".tab").empty().append(this.statsView.el).show();
    },

    onTabChange: function(e){
      var a = $(e.target);
      var links = $(this.el).find(".views").find("a");
      $(this.el).find(".views").addClass("inTab");
      links.removeClass("selected");
      a.addClass("selected");

      return false;
    },

    template: function() {
      var key = "stream_"+this.model.get("streamable_type").toLowerCase();
      return JST[key];
    },

    render: function() {
      var partial = Haml.render(this.template(), { locals: {stream: this.model} });
      $(this.el).addClass("update")
                .addClass(this.model.get("streamable_type").toLowerCase())
                .attr("id", "stream_"+this.model.get("id"))
                .html(Haml.render(JST.stream, { locals: {stream_partial: partial} }));
      $(this.el).find("abbr").attr("title", this.model.get("created_at"));
      $(this.el).find("abbr").timeago();

      return this;
    },
  });
});

