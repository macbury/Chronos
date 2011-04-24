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
      
      this.$("#providers a").click(function(){
        if($(this).attr("data-basic_auth") == "true") {
          redirect_to(basic_auth_path({ provider: $(this).attr("data-provider") }));
          return false;
        }
      });
      
      return this;
    },
  });
});

