$(function(){
  App.Views.SocialAccounts = Backbone.View.extend({
    el: "body",

    initialize: function(){
      _.bindAll(this, 'render');
      App.Storage.SocialAccounts.bind("refresh", this.render);

    },

    render: function() {
      this.$("#workspace").html(Haml.render(JST.social_accounts, { locals: {} }));

      return this;
    },
  });
});

