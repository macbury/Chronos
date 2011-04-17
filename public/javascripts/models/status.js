$(function(){
  App.Models.Status = Backbone.Model.extend({
    url: "/statuses",

    validate: function(attrs) {
      if (attrs.body.length > App.Models.Status.MaxMessageLength) {
        return "Treść wpisu nie może być większe od "+App.Models.Status.MaxMessageLength + " znaków!";
      }

      if (attrs.body.length < 5) {
        return "Treść wpisu nie może być mniejsza niż 5 znaków!";
      }
    }
  });

  App.Models.Status.MaxMessageLength = 140;
});

