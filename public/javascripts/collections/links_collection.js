$(function(){
  App.Collections.Links = Backbone.Collection.extend({
    model: App.Models.Link,
    downloaded: false,
    download: function() {
      if(this.length == 0 && !this.downloaded) {
        this.downloaded = true;
        this.fetch();
      }
    },
    
    done: function() {
      return this.filter(function(link){ return link.success(); });
    },
    
    remaining: function() {
      return this.without.apply(this, this.done());
    },
  });
});
