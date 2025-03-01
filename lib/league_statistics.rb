class LeagueStatistics
    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    # Helpers

    def team_name(team_id) # Finds the team name based on the team_id
        team = @teams.find do |team|
            team[:team_id] == team_id
        end

        if team.nil?
            'Unknown Team'
        else
            team[:teamName]
        end
    end

    def calculate_avg_goals(team_id)
        games_played = @games.select do |game|
            game[:away_team_id] == team_id || game[:home_team_id] == team_id
        end

        total_goals = games_played.sum do |game|
            if game[:home_team_id] == team_id
                game[:home_goals].to_i
            else
                game[:away_goals].to_i
            end
        end

        total_games = games_played.size

        if total_games.zero? #Guard against zero
            0.0
        else
            total_goals.to_f / total_games
        end
    end

    def team_avg_goals_by_hoa(hoa) # Starts with the hoa argument to determine home or away games
        #filters the games dataset and keeps the home or away data based on the hoa argument. .select based on this condition.
        filtered_games = @games.select do |game|
            if hoa == 'home'
                game[:home_team_id]
            else
                game[:away_team_id]
            end
        end.group_by do |game| # Next I want to group the data by team id.
            if hoa == 'home' # If hoa = home, group by home_team_id
                game[:home_team_id]
            else # If hoa = away, group by away_team_id
                game[:away_team_id]
            end
        end

        #At this point, I'm expecting a hash with the home/away team id as keys, 
        ## and the values are arrays with game data.

        filtered_games.transform_keys do |team_id| #Converting team id keys to team names.
            team_name(team_id)
        end.transform_values do |games| #Converting the array values to the teams average goals per game.
            calculate_avg_goals(games.first[:home_team_id] || games.first[:away_team_id]) #takes the first home/away team id and passes into calculate avg goals.
        end

        #Final result, hash with keys team names, and values of average goals, based on the argument of hoa
    end

    # Methods

    def count_of_teams #counts number of teams in the csv
        @teams.size
    end
  
    def best_offense
        
    end
  
    def worst_offense
      
    end
  
    def highest_scoring_visitor
       
    end
  
    def highest_scoring_home_team
      
    end
  
    def lowest_scoring_visitor
      
    end
  
    def lowest_scoring_home_team
      
    end
end