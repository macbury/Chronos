$(function(){
  App.Views.NewEvent = Backbone.View.extend({
    tagName:  "div",
    textProcessInterval: null,

    events: {
      //"click .views": "onTabChange",
    },

    initialize: function() {
      _.bindAll(this, 'render', 'remove', 'add');
      //this.model.links.bind('refresh', this.render);
      //this.model.links.bind('change', this.render);
      var self = this;
      this.model.bind("error", function(model, error_msg) {
        $(self.el).dialog("close");
        error("Nie można dodać wpisu!", error_msg, function() {
          $(self.el).dialog("open");
        });
      });
    },

    add: function() {
      var self = this;
      var form = {
        title: $(this.el).find(".name").val(),
        where: $(this.el).find(".where").val(),
        start_date: $(this.el).find(".start_date").val(),
        end_date: $(this.el).find(".end_date").val(),
        description: $(this.el).find(".description").val(),
      };
      var valid = this.model.set(form);

      if(valid) {
        this.model.save(form, {
          success: function() {
            var raw_obj = self.model.attributes.stream;
            raw_obj["streamable"] = self.model.attributes;
            App.Storage.Streams.add([raw_obj]);
          },
        });
        $(this.el).dialog("close");
      }
    },

    remove: function() {

    },

    render: function() {
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.new_event, { locals: { event: this.model } }));
      $(this.el).dialog({
        title: "Nowe wydarzenie",
        autoOpen: false,
        show: "fade",
        hide: "fade",
        width: 600,
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

      $(this.el).find(".start_date, .end_date").datetimepicker({
        //minDate: new Date(),
        stepMinute: 30,
      });

      $(this.el).dialog("open");
      return this;
    },
  });
});

