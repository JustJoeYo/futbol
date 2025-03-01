class LeagueStatistics
    attr_reader :teams, :game_teams

    def initialize(teams, game_teams)
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

    def calculate_avg_goals
       
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