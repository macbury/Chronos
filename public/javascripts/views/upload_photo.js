$(function(){
  App.Views.UploadPhoto = Backbone.View.extend({
    tagName: "div",
    uploader: null,

    files: {},
    done_files: 0,

    initialize: function(options) {
      _.bindAll(this, 'render', 'progress', 'complete', 'done', 'close');
      var self = this;

      this.uploader = new qq.FileUploaderBasic({
        button: $('.menu .photo')[0],
        multiple: true,
        maxConnections: 1,
        action: '/data',
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        onSubmit: function(id, fileName){
          self.files[id] = { loaded: 0, total: 0 };
          self.done_files = 0;
          self.render();
        },
        onComplete: this.complete,
        onProgress: this.progress
      });
    },

    progress: function(id, fileName, loaded, total) {
      this.files[id] = { loaded: loaded, total: total };
    },

    close: function() {
      this.files = {};
      $(this.el).dialog("close");
    },

    done: function() {
      return Math.round(this.done_files * 100 / _.size(this.files));
    },

    complete: function() {
      this.done_files += 1;
      this.refresh();
    },

    refresh: function() {
      this.$("#upload_progress").text("Wysyłano " + this.done_files + " z " +_.size(this.files) + " zdjęć");

      this.$('.progressbar .progress').css({
        width: this.done() + "%"
      });
    },

    render: function() {
      var self = this;
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.new_photo, { }));
      $(this.el).dialog({
        title: "Zdjęcia",
        autoOpen: false,
        show: "fade",
        width: 530,
        resizable: false,
        modal: true,
        close: this.close,
        buttons: {
          'Publikuj': this.add,
          'Anuluj': this.close
        }
      });
      this.refresh();
      $(this.el).dialog("open");
      return this;
    },
  });
});

