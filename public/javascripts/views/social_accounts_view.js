$(function(){
  App.Views.SocialAccounts = Backbone.View.extend({
    el: "body",

    initialize: function(){
      _.bindAll(this, 'render');
      App.Storage.SocialAccounts.bind("refresh", this.render);
    },

    render: function() {
      this.$("#workspace").html(Haml.render(JST.social_accounts, { locals: { providers: App.Storage.Providers, accounts: App.Storage.SocialAccounts.models } }));
      this.$(".navigation.features li:even").addClass("alt");
      
      /*this.$("#providers li a").click(function(){
        var w = window.open($(this).attr("href"),'Dodaj serwis','width=1000,height=600');
        return false;
      });*/
      
      return this;
    },
  });
});

