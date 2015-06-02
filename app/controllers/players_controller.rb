class PlayersController < ApplicationController
  respond_to :json

  def index
    @game = Game.find(params[:game_id])
    @player = Player.new
    @players = @game.players
  end

  def create
    fname, lname, pts = player_params
    full_name = "#{fname.capitalize} #{lname.capitalize}"
    game = Game.find(params[:game_id])
    new_score = Player.find_or_create_by(name: full_name, game: game)
    new_score.points += pts.to_i
    
    binding.pry
    if new_score.save
      respond_to do |format|
        format.json { render json: { players: players } }
      end
    else
      respond_to do |format|
        format.json { render json: 
          { errors: new_score.errors.full_messages }, status: 403 
        }
      end
    end
  end

  private

  def player_params
    params[:player][:name].scan(/\w+/)
  end
end