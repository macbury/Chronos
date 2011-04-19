$(function(){
  App.Models.Status = Backbone.Model.extend({
    url: "/statuses",
    body: "",

    toJSON : function() {
      return { status: _.clone(this.attributes) };
    },

    validate: function(attrs) {
      if (attrs.body == null) {
        return "Treść wpisu musi być podana!";
      }

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

