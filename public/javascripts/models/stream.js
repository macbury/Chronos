$(function(){
  App.Models.Stream = Backbone.Model.extend({
    url: "/streams",
    initialize: function(){
      _.bindAll(this, 'attachStreamable', 'attachLinks');
      this.links = new App.Collections.Links();

      this.bind('change:streamable', this.attachStreamable);
      this.bind('change:id', this.attachLinks);
      this.bind('change', this.attachStreamable);
      this.bind('change', this.attachLinks);
      this.attachStreamable();
      this.attachLinks();
    },
    
    attachLinks: function() {
      this.url = "/streams/"+this.get("id");
      this.links.url = '/streams/' + this.get("id") + '/links';
    },
    
    attachStreamable: function() {
      if(this.get("streamable_type"))
        this.streamable = new App.Models[this.get("streamable_type")](this.get("streamable"));
    },
    
    isStatus: function() {
      return (this.get("streamable_type") == "Status");
    },

    progress: function() {
      var progress = this.links.done().length * 100 / this.links.length;
      return Math.min(progress, 100);
    }
  });
});

