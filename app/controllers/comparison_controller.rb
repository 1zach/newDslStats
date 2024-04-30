class ComparisonController < ApplicationController

  def index

   if params.has_key?(:player_id1)
    @player1 = Player.find(params[:player_id1])
    @player2 = Player.find(params[:player_id2])
    @player3 = Player.find(params[:player_id3])
   else
    @player1=  Player.includes(:stats).order("stats.runs DESC").first
    @player2 = Player.includes(:stats).order("stats.runs DESC").second
    @player3 = Player.includes(:stats).order("stats.runs DESC").third
   end

    @slashes1 = {avg: @player1.avg, slg: @player1.slg, obp: @player1.obp}
    @slashes2 = {avg: @player2.avg, slg: @player2.slg, obp: @player2.obp}
    @slashes3 = {avg: @player3.avg, slg: @player3.slg, obp: @player3.obp}
    
    @totals1 = @player1.totals
    @totals2 = @player2.totals
    @totals3 = @player3.totals
    
    @totals1slashes = @player1.totals.merge(@slashes1)
    @totals2slashes = @player2.totals.merge(@slashes2)
    @totals3slashes = @player3.totals.merge(@slashes3)
    
    @season_avg1 = @player1.season_avg
    @season_avg2 = @player2.season_avg
    @season_avg3 = @player3.season_avg

@highlighted_values = {}

@totals1.each_key do |key|
  value1 = @totals1[key] || 0
  value2 = @totals2[key] || 0
  value3 = @totals3[key] || 0
  
  max_value = [value1, value2, value3].max
  max_hash = case max_value
             when value1 then @player1.name
             when value2 then @player2.name
             when value3 then @player3.name
             end
  
  @highlighted_values[key] = { max_value: max_value, max_hash: max_hash }
end

  end
end
