window.error = function(title, message, callback) {
  var div = $(Haml.render(JST.error_dialog, { locals: {message: message} }));
  div.dialog({
    title: title,
    modal: true,
    width: 320,
    show: "puff",
    hide: "fade",
    resizable: false,
    close: function() {
      $(div).remove();
      callback();
    },
    buttons: {
      'OK': function() {
        $(this).dialog("close");
      }
    }
  });
}

