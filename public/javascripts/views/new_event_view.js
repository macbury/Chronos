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
        image: $(this.el).find("#flyaer_image_input").val(),
      };

      var valid = this.model.set(form);

      if(valid) {
        App.Storage.Streams.fetchOnce();
        this.model.save(form, {
          success: function() {
            var raw_obj = self.model.attributes.stream;
            raw_obj["streamable"] = self.model.attributes;
            App.Storage.Streams.add([raw_obj]);
            
            redirect_to(stream_path({ id: raw_obj.id }));
          },
        });
        $(this.el).dialog("close");
      }
    },

    remove: function() {

    },

    render: function() {
      var self = this;
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.new_event, { locals: { event: this.model } }));
      $(this.el).dialog({
        title: "Nowe wydarzenie",
        autoOpen: false,
        show: "fade",
        hide: "fade",
        width: 870,
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
      self.$('#flayer_progress').hide();
      self.$('#flayer_upload').show();
      var uploader = new qq.FileUploaderBasic({
        button: this.$('#flayer_upload')[0],
        multiple: false,
        debug: true,
        action: '/events/upload',
        onSubmit: function(id, fileName){
          self.$('#flayer_upload').hide();
          self.$('#flayer_progress').show();
        },
        onProgress: function(id, fileName, loaded, total){
          var done = Math.round(loaded * 100 / total);
          self.$('#flayer_progress .progressbar .progress').animate({
            width: done + "%"
          });
        },
        onComplete: function(id, fileName, resp){
          self.$('#flayer_progress').hide();
          self.$('#flayer_upload').show();
          self.$(".flyaer img").attr("src", resp["file"]);
          self.$('#flyaer_image_input').val(resp["file_name"]);
        },
      });
      
      $(this.el).dialog("open");
      return this;
    },
  });
});

