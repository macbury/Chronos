$(function(){
  App.Collections.Stream = Backbone.Collection.extend({
    model: App.Models.Stream,
    url: '/streams',
    initialize: function(){
      App.Faye.subscribe("/"+$('meta[name=auth_token]').attr('content')+"/notifications/links", function(data) {
        var data = jQuery.parseJSON(data);
        var streamRecord = App.Storage.Streams.get(data["stream_id"]);
        if(streamRecord != null) {
          if (streamRecord.links.length == 0) {
            streamRecord.links.download();
          } else {
            streamRecord.links.get(data["id"]).set(data);
          }
        }
      });
    }
  });
});

