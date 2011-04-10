$(document).ready(function(){ 
  $('.views a').live("click", function(){
    var links = $(this).parents(".views").find("a");
    var update_id = $(this).parents(".views").attr("data-id");
    links.removeClass("selected");
    
    $.each(links, function(){
      var id = $(this).attr("href");
      $(id).hide();
    });
    
    $('#show_'+update_id).show();
    $($(this).attr("href")).show();
    
    $(this).addClass("selected");
    return false;
  });
  
  $('.show_button').live("click", function() {
    var update_id = $(this).attr("data-id");
    var links = $("#update_"+update_id).find(".views a");
    links.removeClass("selected");
    
    $.each(links, function(){
      var id = $(this).attr("href");
      $(id).hide();
    });
    
    $(this).hide();
    
    return false;
  });
});
