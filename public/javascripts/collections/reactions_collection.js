$(function(){
  App.Collections.Reactions = Backbone.Collection.extend({
    model: App.Models.Reaction,
    downloaded: false,
    
    comparator: function(reaction) {
      var d = new Date(reaction.get("created_at"));
      return d * -1;
    },

    unreaded: function() {
      return this.filter(function(reaction){ return reaction.get('unread'); });
    },

    download: function() {
      if(this.length == 0 && !this.downloaded) {
        this.downloaded = true;
        this.fetch();
      }
    },

  });
});

