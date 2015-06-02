class GamesController < ApplicationController
  respond_to :json

  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    game = Game.new(game_params)

    if game.save
      respond_to do |format|
        format.json { render json: game }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: game.errors.full_messages }, status: 403 }
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end