$(function(){
  App.Views.SocialAccount = Backbone.View.extend({
    el: "body",

    initialize: function(){
      _.bindAll(this, 'render', 'process');
      this.model.bind("change", this.render);
      $.get("/streams/"+this.model.get("id")+"/chart", this.process);
    },

    process: function(data) {
      this.data = data;
      this.render();
    },

    render: function() {
      this.$("#workspace").html(Haml.render(JST.social_account, { locals: { account: this.model } }));
      
      if(this.data != null) {
        this.$("#stats").append("<div class='chart' />");
        this.$(".chart").append("<div class='content' />");

        $.plot(this.$(".chart .content"), this.data, {
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
        this.$("#stats").append("<div class='please_wait'>Wczytywanie danych...</div>");
      }
      return this;
    },
  });
});

