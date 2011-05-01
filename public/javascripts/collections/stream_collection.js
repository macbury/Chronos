$(function(){
  App.Collections.Stream = Backbone.Collection.extend({
    model: App.Models.Stream,
    url: '/streams',
    fetched: false,
    
    initialize: function(){
      _.bindAll(this, "fetchOnce");
    },
    
    fetchOnce: function() {
      if(!this.fetched) {
        this.fetch();
        this.fetched = true;
      }
    }
  });
});

