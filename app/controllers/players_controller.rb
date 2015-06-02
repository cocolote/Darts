class PlayersController < ApplicationController
  respond_to :json

  def index
    @game = Game.find(params[:game_id])
    @player = Player.new
    @players = @game.players.order(points: :desc)
  end

  def create
    fname, lname, pts = player_params
    full_name = "#{fname.capitalize} #{lname.capitalize}"
    game = Game.find(params[:game_id])
    new_score = Player.find_or_create_by(name: full_name, game: game)
    new_score.points += pts.to_i
    if new_score.save
      respond_to do |format|
        format.json { render json: game.players.order(points: :desc) }
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
    game = Game.find(params[:game_id])
    Player.find_by(id: params[:id], game_id: params[:game_id]).delete
    respond_to do |format|
      format.json { render json: game.players.order(points: :desc) }
    end
  end

  private

  def player_params
    params[:player][:name].scan(/\w+/)
  end
end