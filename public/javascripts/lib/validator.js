window.Validate = {
  presence: function(attr) {
    return (attr != null && attr.length > 0);
  },

  size: function(attr, min, max) {
    return Validate.presence(attr) && (attr.length >= min && attr.length <= max);
  }
}

