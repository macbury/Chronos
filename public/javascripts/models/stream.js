$(function(){
  App.Models.Stream = Backbone.Model.extend({
    initialize: function(){
      this.links = new App.Collections.Links();
      this.links.url = '/streams/' + this.id + '/links';
      //this.links.bind("refresh", this.updateCounts);
    }
  });
});
