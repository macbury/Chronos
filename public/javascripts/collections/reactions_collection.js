$(function(){
  App.Collections.Reactions = Backbone.Collection.extend({
    model: App.Models.Reaction,
    downloaded: false,
    
    comparator: function(reaction) {
      var d = new Date(reaction.get("created_at"));
      return d * -1;
    },

    download: function() {
      if(this.length == 0 && !this.downloaded) {
        this.downloaded = true;
        this.fetch();
      }
    },

  });
});

