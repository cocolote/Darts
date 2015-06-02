$('#new_game').on('ajax:success', function(e, game){
  gameHTML = [];

  gameHTML.push('<li class="medium-3 columns games"><h3>');
  gameHTML.push('<a href=/games/'+game.id+'/players>');
  gameHTML.push(game.name+'</a></h3></li>');
  debugger;
  $('#game_name').value('');
  $('#games-names-list').append(gameHTML.join(''));
});

$(function(){
  var current_position = window.scrollY;

  $(window).on('scroll', function(e){
    if (window.scrollY > current_position){
      $(window).bind('scroll',function(e){
          parallaxScroll('#games-container');
      });
    }
  });
});

function parallaxScroll(element){
  var scrolled = $(window).scrollTop();
  $(element).css('top',(75-(scrolled*0.06))+'vh');
}