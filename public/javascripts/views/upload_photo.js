$(function(){
  App.Views.UploadPhoto = Backbone.View.extend({
    tagName:  "div",


    initialize: function() {
      _.bindAll(this, 'render');

    },

    render: function() {
      var self = this;
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.new_photo, { }));
      $(this.el).dialog({
        title: "Zdjęcia",
        autoOpen: false,
        show: "fade",
        hide: "fade",
        width: 480,
        resizable: false,
        modal: true,
        close: this.remove,
        buttons: {
          'Publikuj': this.add,
          'Anuluj': function() {
            $(this).dialog("close");
          }
        }
      });
      
      $(this.el).dialog("open");
      return this;
    },
  });
});

