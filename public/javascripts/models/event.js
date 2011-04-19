$(function(){
  App.Models.Event = Backbone.Model.extend({
    url: "/events",
    start_date: new Date(),
    end_date: new Date(),
    title: "",
    description: "",
    where: "",

    toJSON : function() {
      return { event: _.clone(this.attributes) };
    },

    validate: function(attrs) {

      if(!Validate.size(attrs.title, 5, 255)) {
        return "Musisz podać nazwę wydarzenia, musi ona mieć minimalnie 5 znaków a maksymalnie 255";
      }

      if(!Validate.size(attrs.description, 5, 400)) {
        return "Musisz podać opis wydarzenia, musi ona mieć minimalnie 5 znaków a maksymalnie 400";
      }

      if(!Validate.size(attrs.where, 5, 255)) {
        return "Musisz podać miejsce wydarzenia, musi ona mieć minimalnie 5 znaków a maksymalnie 255";
      }
    }
  });

});

