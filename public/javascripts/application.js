$(function(){
  $('button[data-url]').click(function(e){
    var button = $(this);
    
    window.location = button.attr('data-url');
  });
});

var PuzzleNode = {};

PuzzleNode.about = function(){
  var visible = $("#about").is(":visible");
  
  $("#footer").toggleClass("active"); 
  
  if(visible) $.scrollTo('header', 500, { easing:'swing' });
 
  $('#footer .teaser').fadeToggle();
  
  $('#about').slideToggle(200, function(){
    if(!visible) $.scrollTo('#about', 500, { easing:'swing' });
  });
};