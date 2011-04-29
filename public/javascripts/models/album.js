$(function(){
  App.Models.Album = Backbone.Model.extend({
    url: "/albums",
    
    toJSON : function() {
      return { album: _.clone(this.attributes) };
    },

  });

});

