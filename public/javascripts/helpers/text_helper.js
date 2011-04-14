String.prototype.truncate = function(length) {
  var out = this.substring(0,length);
  
  if (this.length > length) {
    out = out + "...";
  }
  
  return out;
}

String.prototype.strip_tags = function() {
  return this.replace(/<\/?[^>]+(>|$)/g, "");
}
