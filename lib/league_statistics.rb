class LeagueStatistics
    attr_reader :teams, :game_teams

    def initialize(teams, game_teams)
        @teams = teams
        @game_teams = game_teams
    end

    def count_of_teams #counts unique team ids for a count of teams
        @teams['team_id'].uniq.count
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