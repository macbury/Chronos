$(function(){
  App.Models.Reaction = Backbone.Model.extend({
    url: "/reactions",
    
    toJSON : function() {
      return { reaction: { unread: this.get("unread") } };
    },
  });
});
