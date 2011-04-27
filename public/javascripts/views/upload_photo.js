$(function(){
  App.Views.UploadPhoto = Backbone.View.extend({
    tagName: "div",
    uploader: null,

    initialize: function(options) {
      _.bindAll(this, 'render', 'progress', 'complete');
      var self = this;
      this.uploader = new qq.FileUploaderBasic({
        button: $('.menu .photo')[0],
        multiple: true,
        maxConnections: 1,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        onSubmit: function(id, fileName){
          self.render();
        },
        onComplete: this.complete,
        onProgress: this.progress
      });
    },
    
    progress: function(id, fileName, loaded, total) {
      
      var done = Math.round(loaded * 100 / total);
      this.$('.progressbar .progress').animate({
        width: done + "%"
      });
    },
  
    complete: function() {
    
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
        width: 530,
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

