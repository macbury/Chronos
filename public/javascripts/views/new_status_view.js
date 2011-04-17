$(function(){
  App.Views.NewStatus = Backbone.View.extend({
    tagName:  "div",
    textProcessInterval: null,

    events: {
      //"click .views": "onTabChange",
    },

    initialize: function() {
      _.bindAll(this, 'render', 'remove', 'textProcess', 'startTimer', 'stopTimer', 'add');
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
      var valid = this.model.set({
        body: $(this.el).find(".status_body").val()
      });

      if(valid) {
        this.model.save();
        $(this.el).dialog("close");
      }
    },

    remove: function() {
      this.stopTimer();
      //$(this.el).remove();
    },

    startTimer: function() {
      this.stopTimer();
      this.textProcessInterval = setTimeout(this.textProcess, 100);
    },

    stopTimer: function() {
      clearTimeout(this.textProcessInterval);
      this.textProcessInterval = null;
    },

    textProcess: function() {
      var url_regexp = /(https?:\/\/[^\>\<\s\"]+)( |\n|\t)/ig
      var contentArea = $(this.el).find(".status_body");
      var urls = contentArea.val().match(url_regexp);
      var regexp = new RegExp(window.location.host, "ig");
      var startTheTimer = true;
      this.stopTimer();
      var self = this;
      if (urls) {
        _.each(urls, function (url) {
          if (url.match(regexp) == null) {
            startTheTimer = false;
            $.post("/redirect", { url: url }, function(data){
              var content = contentArea.val();
              content = content.replace(url, data.link + " ");
              contentArea.val(content);
              self.startTimer();
            });
          }
        });
      }

      $(this.el).parents(".ui-dialog").find('.chars_count').text(App.Models.Status.MaxMessageLength - contentArea.val().length);

      if(startTheTimer) {
        this.startTimer();
      }
    },

    render: function() {
      $(this.el).empty();
      $(this.el).html(Haml.render(JST.new_status, { locals: {} }));
      $(this.el).dialog({
        title: "Nowy wpis",
        autoOpen: false,
        show: "fade",
        hide: "fade",
        width: 490,
        resizable: false,
        height: 252,
        modal: true,
        close: this.remove,
        buttons: {
          'Publikuj': this.add,
          'Anuluj': function() {
            $(this).dialog("close");
          }
        }
      });
      $(this.el).parents(".ui-dialog").find('.ui-dialog-buttonpane').append("<div class='chars_count'>140</div>");

      this.startTimer();

      $(this.el).dialog("open");
      return this;
    },
  });
});

