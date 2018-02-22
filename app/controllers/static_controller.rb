class StaticController < ApplicationController
  def index
    @games = Game.all
  end
end
