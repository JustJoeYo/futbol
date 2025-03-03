class SeasonStatistics
    attr_reader :game_teams, :games, :teams
    def initialize(game_teams,games,teams)
        @game_teams = game_teams
        @games = games
        @teams = teams
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

    #helper method three - makes a nested array grouped by team_id
    def group_by_team(season_id)
        games = games_in_season(season_id)

        grouped_arrays = games.group_by do |row|
            row[:team_id]
        end.values
        grouped_arrays
    end

    #helper method four
    def calculate_coach_stats(season_id)
        grouped_array = group_by_coach(season_id)
        
        coach_stats = {}
        grouped_array.each do |coach_array|  
            wins = 0
            games = 0
            coach_array.map do |row| 
                if row[:result] == "WIN"
                    wins += 1
                end
                games += 1
                coach_stats[row[:head_coach]] = {wins: wins, games: games}
            end
        end
        coach_stats
        
    end

    #helper method five
    def calculate_team_stats(season_id,stat)
        grouped_array = group_by_team(season_id)
        team_stats = {}

        grouped_array.each do |team_array|
            total_stat = team_array.sum { |row| row[stat].to_i }
            team_stats[team_array.first[:team_id]] = {stat: total_stat}
        end

        team_stats
        binding.pry
    
    end

    def winningest_coach(season_id)
        coach_stats = calculate_coach_stats(season_id)

        best_coach = coach_stats.max_by do |coach,stats|
            (stats[:wins].to_f / stats[:games].to_f) * 100
            
        end
        
        return best_coach[0]
    
    end
  
    def worst_coach(season_id)
        coach_stats = calculate_coach_stats(season_id)

        worst_coach = coach_stats.min_by do |coach,stats|
            (stats[:wins].to_f / stats[:games].to_f) * 100
            
        end
    
        return worst_coach[0]
      
    end

    # def most_accurate_team(season_id)
    #     shots_stats = calculate_team_stats(season_id, :shots) #{"3"=>23, "6"=>38}
    #     goal_stats = calculate_team_stats(season_id, :goal) #{"3"=>0, "6"=>0}

    #     accuracy = team_stats.transform_values { |shots| shots.to_f / goals_stats[shots].to_f }
    #     # ["6", {:shots=>38, :goals=>11}]

    #     binding.pry

    # end
    
  
    def most_accurate_team(season_id)
        grouped_array = group_by_team(season_id)

        team_stats = {}
        grouped_array.each do |team_array|
            shots = 0
            goals = 0
            team_array.map do |row|
                shots += row[:shots].to_i
                goals += row[:goals].to_i

                team_stats[row[:team_id]] = {shots: shots, goals: goals}
                
            end
        end
        most_accurate = team_stats.min_by do |team,stats| #lower ratio means more accurate
            stats[:shots].to_f / stats[:goals].to_f
        end
        #binding.pry

        most_accurate[0] #this returns the team_id

        team_name_row = @teams.find do |row| #returns row that has the teamname for team_id
            most_accurate[0] == row[:team_id].to_s
        end

        team_name = team_name_row[:teamname]
        return team_name
    end
  

    def least_accurate_team(season_id)
        grouped_array = group_by_team(season_id)

        team_stats = {}
        grouped_array.each do |team_array|
            shots = 0
            goals = 0
            team_array.map do |row|
                shots += row[:shots].to_i
                goals += row[:goals].to_i

                team_stats[row[:team_id]] = {shots: shots, goals: goals}
                
            end
        end
        least_accurate = team_stats.max_by do |team,stats| #higher ratio means less accurate
            stats[:shots].to_f / stats[:goals].to_f
        end

        least_accurate[0] #this returns the team_id

        team_name_row = @teams.find do |row| #returns row that has the teamname for team_id
            least_accurate[0] == row[:team_id].to_s
        end

        team_name = team_name_row[:teamname]
        return team_name
    end
    
   

    def most_tackles(season_id)
        grouped_array = group_by_team(season_id)

        team_stats = {} #{"3"=>{:tackles=>114}, "6"=>{:tackles=>139}}
        grouped_array.each do |team_array|
            tackles = 0
            team_array.map do |row|
                tackles += row[:tackles].to_i

                team_stats[row[:team_id]] = {tackles: tackles}
            end
        end
        most_tackles = team_stats.max_by do |team,stats|
             stats[:tackles]
        end
        binding.pry
        team_name_row = @teams.find do |row|
            most_tackles[0] == row[:team_id].to_s
        end

        team_name = team_name_row[:teamname]
        return team_name
    end
  
    def fewest_tackles(season_id)
        grouped_array = group_by_team(season_id)

        team_stats = {}
        grouped_array.each do |team_array|
            tackles = 0
            team_array.map do |row|
                tackles += row[:tackles].to_i

                team_stats[row[:team_id]] = {tackles: tackles}
            end
        end
        least_tackles = team_stats.min_by do |team,stats|
             stats[:tackles]
        end
        
        team_name_row = @teams.find do |row|
            least_tackles[0] == row[:team_id].to_s
        end

        team_name = team_name_row[:teamname]
        return team_name
    
    end
end