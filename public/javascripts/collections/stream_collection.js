$(function(){
  App.Collections.Stream = Backbone.Collection.extend({
    model: App.Models.Stream,
    url: '/streams'
  });
});
