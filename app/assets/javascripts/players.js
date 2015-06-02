// NEW PLAYER OR ADDED POINTS
$('#new_player').on('ajax:success', function(e, data){
  $('#players-scores-table ul').empty();

  var listHTML = refreshList(data.players, data.game_id);

  $('#player_name').val('');
  $('#players-scores-table ul').append(listHTML.join(''));
});

// DELETE USERS
$('#players-scores-table ul').on('ajax:success', '.fi-trash', function(e, data){
  $('#players-scores-table ul').empty();

  var listHTML = refreshList(data.players, data.game_id);

  $('#player_name').val('');
  $('#players-scores-table ul').append(listHTML.join(''));
});

function refreshList(players, game_id) {
  playersHTML = [];

  playersHTML.push('<li class="row">');
  playersHTML.push('<h6 class="table-columns small-2 column ranking">');
  playersHTML.push('Ranking</h6">');
  playersHTML.push('<h6 class="table-columns small-7 column name">');
  playersHTML.push('Name</h6">');
  playersHTML.push('<h6 class="table-columns small-2 column points">');
  playersHTML.push('Points</h6">');
  playersHTML.push('<h6 class="table-columns small-1 column points">');
  playersHTML.push('</h6"></li>');

  var currentPoints = 0;
  var rank = 1;
  for(var i = 0; i < players.length; i++) {
    currentPoints > players[i].points ? rank++ : rank;
    currentPoints = players[i].points;

    playersHTML.push('<li class="row">');
    playersHTML.push('<h6 class="table-columns small-2 column ranking">');
    playersHTML.push(rank+'</h6">');
    playersHTML.push('<h6 class="table-columns small-7 column name">');
    playersHTML.push(players[i].name+'</h6">');
    playersHTML.push('<h6 class="table-columns small-2 column points">');
    playersHTML.push(players[i].points+'</h6">');
    playersHTML.push('<h6 class="table-columns small-1 column points">');
    playersHTML.push('<a class="fi-trash" data-remote="true" rel="nofollow"\
data-method="delete" href="/games/'+game_id+'/players/'+players[i].id+'">');
    playersHTML.push('</a></h6"></li>');
  }
  return playersHTML;
}