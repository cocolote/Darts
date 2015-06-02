class PlayersController < ApplicationController
  respond_to :json

  def index
    @game = Game.find(params[:game_id])
    @player = Player.new
    @players = @game.players.order(points: :desc)
  end

  def create
    fname = player_params[0][0]
    lname = player_params[0][1]
    pts   = player_params[1][0]
    full_name = "#{fname} #{lname}"
    game = Game.find(params[:game_id])
    new_score = Player.find_or_create_by(name: full_name, game: game)
    new_score.points += pts.to_i
    if new_score.save
      respond_to do |format|
        format.json { render json: { players: game.players.order(points: :desc),
                                     game_id: game.id } }
      end
    else
      respond_to do |format|
        format.json { render json: 
          { errors: new_score.errors.full_messages }, status: 403 
        }
      end
    end
  end

  def destroy
    Player.find_by(id: params[:id], game_id: params[:game_id]).delete
    game = Game.find(params[:game_id])
    respond_to do |format|
      format.json { render json: { players: game.players.order(points: :desc),
                                   game_id: game.id } }
    end
  end

  private

  def player_params
    [params[:player][:name].scan(/[a-z]+/i).map { |e| e.capitalize },
     params[:player][:name].scan(/\d+/)]
  end
end