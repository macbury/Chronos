$(function(){
  App.Views.UploadPhoto = Backbone.View.extend({
    tagName: "div",
    uploader: null,

    files: {},
    uploaded_files: [],
    
    done_files: 0,

    initialize: function(options) {
      _.bindAll(this, 'render', 'progress', 'complete', 'done', 'close', 'add', 'addButton');
      var self = this;

      this.uploader = new qq.FileUploaderBasic({
        button: $('.menu .photo')[0],
        multiple: true,
        maxConnections: 1,
        action: '/data',
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        onSubmit: function(id, fileName){
          self.files[id] = { loaded: 0, total: 0 };
          self.uploaded_files = [];
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

    addButton: function() {
      return $(this.el).parents(".ui-dialog").find('.ui-dialog-buttonset button:first');
    },
  
    done: function() {
      return Math.round(this.done_files * 100 / _.size(this.files));
    },

    complete: function(id, fileName, resp) {
      this.done_files += 1;
      this.uploaded_files.push(resp["file"]);
      this.refresh();
    },

    refresh: function() {
      this.addButton().attr("disabled", "disabled");
      this.$("#upload_progress").text("Wysyłano " + this.done_files + " z " +_.size(this.files) + " zdjęć");

      this.$('.progressbar .progress').animate({
        width: this.done() + "%"
      }, "fast");
      
      if(this.done() == 100) {
        this.addButton().removeAttr("disabled");
      }
    },
    
    add: function() {
    
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
          'Utwórz album': this.add,
          'Anuluj': this.close
        }
      });
      
      this.$("form").submit(function() { return false; });
      
      this.refresh();
      $(this.el).dialog("open");
      return this;
    },
  });
});

