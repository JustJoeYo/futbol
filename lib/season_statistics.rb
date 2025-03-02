class SeasonStatistics
    attr_reader :game_teams, :games
    def initialize(game_teams,games)
        @game_teams = game_teams
        @games = games
    end

    #helper method one - makes an array of all the games in a season
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

    #helper method two - makes a nested array of the data grouped by coach
    def group_by_coach(season_id)
        games = games_in_season(season_id)

        grouped_arrays = games.group_by do |row|
            row[:head_coach]
        end.values
        grouped_arrays
    end

    def winningest_coach(season_id)
        grouped_array = group_by_coach(season_id)
        
        grouped_array.each do |coach_array|  #coach array is the array of hashes [ {}, {} ]
            coach_array.map do |row| #this gives access to each row for the coaches in hash form {}
            
            end
        end
    
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