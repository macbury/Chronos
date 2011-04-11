var DashboardController = {
  init: function() {
    var self = this;
    faye.subscribe("/"+auth_token+"/notifications/link", function(data) {
      var data = jQuery.json(data);
      self.linkUpdateNotification(data);
    });
  },
  
  bindCharts: function() {
    $('.view_tab').bind("chart", function(){
      var update_id = $(this).attr("data-id");
      var li = $(this);
      $.ajax({
        url: "/updates/"+update_id+"/chart",
        type: "GET",
        dataType: "JSON",
        success: function(data){
          data = JSON.parse(data);
          $.plot(li.find(".chart .content"), data, { 
            xaxis: { mode: "time" },
            series: {
             lines: { show: true },
             points: { show: true }
            },
            legend: {
              backgroundColor: "#0a0909",
              labelBoxBorderColor: "#fff"
            },
            
            grid: { hoverable: true, clickable: true },
          });
          
          li.find(".chart .content").bind("plothover", function (event, pos, item) {
            if (item) {
              var uid = item.dataIndex + ":" + item.seriesIndex;
              if (previousPoint != uid) {
                previousPoint = uid;
                
                $("#tooltip").remove();
                var x = item.datapoint[0],
                    y = item.datapoint[1];
                
                showTooltip(item.pageX, item.pageY,
                            item.series.label + ": " + y + " dla " + x);
              }
            } else {
              $("#tooltip").remove();
              previousPoint = null;
            }
          });
        },
      })
    });
  },
  
  bindViews: function() {
    $('.views a').live("click", function(){
      var links = $(this).parents(".views").find("a");
      var update_id = $(this).parents(".views").attr("data-id");
      links.removeClass("selected");
      
      $.each(links, function(){
        var id = $(this).attr("href");
        $(id).hide();
      });
      
      $('#show_'+update_id).show();
      $($(this).attr("href")).trigger($($(this).attr("href")).attr("trigger:action"));
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
  },
  
  linkUpdateNotification: function(data) {
    console.log(data);
  },
};
