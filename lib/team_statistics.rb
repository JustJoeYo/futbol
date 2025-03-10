require_relative 'statistic_helper'

class TeamStatistics
  include StatisticHelper

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  # Team Statistics
  def team_info(team_id)
    team = @teams.find { |t| t.team_id == team_id }
    {
      "team_id" => team.team_id,
      "franchise_id" => team.franchise_id,
      "team_name" => team.team_name,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end

  def best_season(team_id)
    season_win_percentages = season_win_percentages(team_id)
    season_win_percentages.max_by { |season, win_percentage| win_percentage }[0]
  end

  def worst_season(team_id)
    season_win_percentages = season_win_percentages(team_id)
    season_win_percentages.min_by { |season, win_percentage| win_percentage }[0]
  end

  def average_win_percentage(team_id)
    total_games = @game_teams.count { |game_team| game_team.team_id == team_id }
    return 0 if total_games.zero?
    total_wins = @game_teams.count { |game_team| game_team.team_id == team_id && game_team.result == "WIN" }
    (total_wins.to_f / total_games).round(2)
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