$(function(){
  App.Views.Stats = Backbone.View.extend({
    tagName:  "div",
    data: null,
    events: {
      "click .destro": "destroy",
    },

    initialize: function() {
      _.bindAll(this, 'render', 'process', 'destroy');
      $.get("/streams/"+this.model.get("id")+"/chart", this.process);
      this.render();
    },

    destroy: function(){
      this.model.destroy();
      redirect_to(social_accounts());
      return false;
    },

    process: function(data) {
      this.data = data;
      this.render();
    },

    render: function() {
      $(this.el).empty();
      if(this.data != null) {
        $(this.el).append("<div class='chart' />");
        $(this.el).find(".chart").append("<div class='content' />");

        $.plot($(this.el).find(".chart .content"), this.data, {
          xaxis: { mode: "time" },
          series: {
           lines: { show: true },
           points: { show: true }
          },
          legend: {
            backgroundColor: "#0a0909",
            labelBoxBorderColor: "#fff"
          },

          grid: { hoverable: true, clickable: true },
        });
      } else {
        $(this.el).append("<div class='please_wait'>Wczytywanie danych...</div>");
      }
      return this;
    },
  });
});

