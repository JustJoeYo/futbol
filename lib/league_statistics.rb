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