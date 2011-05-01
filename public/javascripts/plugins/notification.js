$.notice = function(options) {
  $.extend({
    title: "",
    description: "",
    icon: "",
    callback: function() {}
  }, options);
  
  var html5Notification = (window["webkitNotifications"] != null);

  if (html5Notification && window.webkitNotifications.checkPermission() == 0) { 
    var notification = window.webkitNotifications.createNotification(options['icon'], options['title'], options['description']);
    notification.onclose = options['callback'];
    notification.show();
  }

}
