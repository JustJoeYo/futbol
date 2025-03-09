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
    wins = games_won_by_team(team_id)

    return 0 if wins.empty? #Edge case guard

    blowouts = wins.map do |game|
      goal_difference(game, team_id)
    end

    blowouts.max
  end

  def worst_loss(team_id) #Andrew
    losses = games_lost_by_team(team_id)

    return 0 if losses.empty? #Edge case guard

    biggest_losses = losses.map do |game|
      goal_difference(game, team_id).abs #Absolute value as the difference will be negative
    end

    biggest_losses.max
  end

  def head_to_head(team_id) #Katya
    
  end

  def seasonal_summary(team_id) #Andrew
    #Step 1, get all games for the team
    team_games = games_involving_team(team_id)

    #Step 2, get unique season
    seasons = team_games.map do |game|
      find_season_by_game_id(game.game_id)
    end

    seasons = seasons.uniq

    #Step 3, iterate through seasons and generate stats
    summary = {}

    seasons.each do |season|
      regular_games = team_games.select do |game|
        find_season_by_game_id(game.game_id) == season && find_game_type(game.game_id) == "Regular Season"
      end

      postseason_games = team_games.select do |game|
        find_season_by_game_id(game.game_id) == season && find_game_type(game.game_id) == "Postseason"
      end

      summary[season] = {
        "regular_season" => calculate_season_stats(regular_games, team_id),
        "postseason" => calculate_season_stats(postseason_games, team_id)
      }
    
    end

    summary
  end

  #Helpers AS

  def games_involving_team(team_id) #finds all games involving team
    @game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def find_season_by_game_id(game_id) #Finds the season for a given game_id
    game_record = @games.find do |game|
      game.game_id == game_id
    end
    game_record.season
  end

  def calculate_season_stats(games, team_id)
    return {
      win_percentage: 0.0,
      total_goals_scored: 0,
      total_goals_against: 0,
      average_goals_scored: 0.0,
      average_goals_against: 0.0
    } if games.empty? #Guard against zero

    total_games = games.size

    total_wins = games.count do |game|
      game.result == "WIN"
    end

    total_goals_scored = games.sum do |game|
      game.goals.to_i
    end

    total_goals_against = games.sum do |game|
      find_opponent_score(game, team_id)
    end

    #Hash creation
    {
      win_percentage: (total_wins.to_f / total_games).round(2),
      total_goals_scored: total_goals_scored,
      total_goals_against: total_goals_against,
      average_goals_scored: (total_goals_scored.to_f / total_games).round(2),
      average_goals_against: (total_goals_against.to_f / total_games).round(2)
    }
  end

  def find_game_type(game_id)
    game_record = @games.find do |game|
      game.game_id == game_id
    end

    game_record.type
  end

  def find_opponent_score(game, team_id) #Finds opponents goals from the game
    game_record = @games.find do |g| #Using g as game is an argument
      g.game_id == game.game_id
    end

    if game_record.home_team_id == team_id
      game_record.away_goals.to_i
    else
      game_record.home_goals.to_i
    end
  end

  def games_won_by_team(team_id) #finds all games where the team won
    @game_teams.select do |game|
      game.team_id == team_id && game.result == "WIN"
    end
  end

  def games_lost_by_team(team_id) #Finds all games where the team lost
    @game_teams.select do |game|
      game.team_id == team_id && game.result == "LOSS"
    end
  end

  def goal_difference(game, team_id) #Finds the goal differential
    game_record = @games.find do |g| #Using g instead of game due to game argument
      g.game_id == game.game_id
    end

    if game_record.home_team_id == team_id
      game_record.home_goals.to_i - game_record.away_goals.to_i
    elsif game_record.away_team_id == team_id
      game_record.away_goals.to_i - game_record.home_goals.to_i
    else
      0 #Edge case guard
    end
  end
end