require './lib/statistic_helper'

class TeamStatistics
  include StatisticHelper

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  # Team Statistics

  def team_info(team_id)
    team = @teams.find { |t| t[:team_id] == team_id }
    {
      team_id: team[:team_id],
      franchise_id: team[:franchiseid],
      team_name: team[:teamname],
      abbreviation: team[:abbreviation],
      link: team[:link]
    }
  end

  def best_season(team_id)
    
  end

  def worst_season(team_id)
    
  end

  def average_win_percentage(team_id)
    
  end

  def most_goals_scored(team_id)
    
  end

  def fewest_goals_scored(team_id)
    
  end

  def favorite_opponent(team_id)
    
  end

  def rival(team_id)
    
  end

  def biggest_team_blowout(team_id)
    
  end

  def worst_loss(team_id)
    
  end

  def head_to_head(team_id)
    
  end

  def seasonal_summary(team_id)
    
  end
end