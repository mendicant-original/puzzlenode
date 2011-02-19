$(function(){
  $('button[data-url]').click(function(e){
    var button = $(this);
    
    window.location = button.attr('data-url');
  });
});