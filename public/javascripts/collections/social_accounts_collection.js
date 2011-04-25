$(function(){
  App.Collections.SocialAccounts = Backbone.Collection.extend({
    model: App.Models.SocialAccount,
    url: "/social_accounts"
  });
});

