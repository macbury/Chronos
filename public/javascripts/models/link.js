$(function(){
  App.Models.Link = Backbone.Model.extend({
    
    type: function() {
      return parseInt(this.get("status_type"));
    },
    
    pending: function(){
      return this.type() == App.Models.Link.Pending;
    },
    
    working: function() {
      return this.type() == App.Models.Link.Working;
    },
    
    success: function() {
      return this.type() == App.Models.Link.Success;
    },
    
    error: function() {
      return this.type() == App.Models.Link.Error;
    },
    
    failure: function() {
      return this.type() == App.Models.Link.Failure;
    },
  });
  
  App.Models.Link.Pending = 0;
  App.Models.Link.Working = 1;
  App.Models.Link.Success = 2;
  App.Models.Link.Error = 3;
  App.Models.Link.Failure = 4;
});
