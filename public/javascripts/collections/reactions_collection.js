$(function(){
  App.Collections.Reactions = Backbone.Collection.extend({
    model: App.Models.Reaction,
    downloaded: false,
    download: function() {
      if(this.length == 0 && !this.downloaded) {
        this.downloaded = true;
        this.fetch();
      }
    },

  });
});

