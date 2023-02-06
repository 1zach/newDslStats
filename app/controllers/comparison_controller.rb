class ComparisonController < ApplicationController

  def index

   if params.has_key?(:player_id1)
    @player1 = Player.find(params[:player_id1])
    @player2 = Player.find(params[:player_id2])
    @player3 = Player.find(params[:player_id3])
   else
    @player1=  Player.includes(:stats).order("stats.hits DESC").first
    @player2 = Player.includes(:stats).order("stats.hits DESC").second
    @player3 = Player.includes(:stats).order("stats.hits DESC").third
   end
    @totals1 = @player1.totals
    @totals2 = @player2.totals
    @totals3 = @player3.totals
    
    @season_avg1 = @player1.season_avg
    @season_avg2 = @player2.season_avg
    @season_avg3 = @player3.season_avg

  end




end
