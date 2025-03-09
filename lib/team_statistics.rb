require_relative 'statistic_helper'

class TeamStatistics
  include StatisticHelper

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  # Team Statistics

  def team_info(team_id) #Joe
    team = @teams.find { |t| t.team_id == team_id }
    {
      team_id: team.team_id,
      franchise_id: team.franchise_id,
      team_name: team.team_name,
      abbreviation: team.abbreviation,
      link: team.link
    }
  end

  def best_season(team_id) #Joe
    
  end

  def worst_season(team_id) #Joe
    
  end

  def average_win_percentage(team_id) #Joe
    
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

  #Helpers AS

  def games_won_by_team(team_id)
    @game_teams.select do |game|
      game.team_id == team_id && game.result == "WIN"
    end
  end

  def games_lost_by_team(team_id)
    @game_teams.select do |game|
      game.team_id == team_id && game.result == "LOSS"
    end
  end

  def goal_difference(game, team_id)
    game_record = @games.find do |g| #Using g instead of game due to game argument
      g.game_id == game.game_id
    end

    if game_record.home_team_id == team_id
      game_record.home_goals.to_i - game_record.away_goals.to_i
    else
      game_record.away_goals.to_i - game_record.home_goals.to_i
    end
  end
end