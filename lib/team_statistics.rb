require_relative 'statistic_helper'

class TeamStatistics
  include StatisticHelper

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  # Helper Methods
  def season_win_percentages(team_id)
    seasons = @games.map { |game| game.season }.uniq
    seasons.each_with_object({}) do |season, percentages|
      total_games = @game_teams.count { |game_team| game_team.team_id == team_id && season(game_team) == season }
      total_wins = @game_teams.count { |game_team| game_team.team_id == team_id && season(game_team) == season && game_team.result == "WIN" }
      percentages[season] = total_games.zero? ? 0 : (total_wins.to_f / total_games).round(2)
    end
  end

  def season(game_team)
    game = @games.find { |g| g.game_id == game_team.game_id }
    game.season
  end

  # Team Statistics
  def team_info(team_id)
    team = @teams.find { |t| t.team_id == team_id }
    {
      team_id: team.team_id,
      franchise_id: team.franchise_id,
      team_name: team.team_name,
      abbreviation: team.abbreviation,
      link: team.link
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
    total_wins = @game_teams.count { |game_team| game_team.team_id == team_id && game_team.result == "WIN" }
    (total_wins.to_f / total_games).round(2)
  end

  def most_goals_scored(team_id) #Katya
    
  end

  def fewest_goals_scored(team_id) #Katya
    
  end

  def favorite_opponent(team_id) #Katya
    
  end

  def rival(team_id) #Andrew
    
  end

  def biggest_team_blowout(team_id) #Andrew
    
  end

  def worst_loss(team_id) #Andrew
    
  end

  def head_to_head(team_id) #Katya
    
  end

  def seasonal_summary(team_id) #Andrew
    
  end
end