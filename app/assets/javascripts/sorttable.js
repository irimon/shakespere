$(function () {
 
  
   $("#sort-table th a, #sort-table .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  
  $("#roles_search input").keyup(function() {
    $.get($("#roles_search").attr("action"), $("#roles_search").serialize(), null, "script");
    return false;
  });
  
});