class SeasonStatistics
    attr_reader :game_teams, :games
    def initialize(game_teams,games)
        @game_teams = game_teams
        @games = games
    end

    #helper method
    def games_in_season(season_id)
        game_ids = []
        @games.each do |game|
            if game[:season] == season_id
               game_ids << game[:game_id]
            end
        end

        season_games = []
        @game_teams.find_all do |games|
            if game_ids.include?(games[:game_id])
                season_games << games.to_h
            end
        end
        season_games
    end

    def winningest_coach(season_id)
        games = games_in_season(season_id)


        
    end
  
    # def worst_coach(season_id)
      
    # end
  
    # def most_accurate_team(season_id)
      
    # end
  
    # def least_accurate_team(season_id)
      
    # end
  
    # def most_tackles(season_id)
      
    # end
  
    # def fewest_tackles(season_id)
      
    # end
end