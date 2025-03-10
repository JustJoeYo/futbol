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

  def most_goals_scored(team_id) #Katya
    max_game = find_teams(team_id).max_by do |game|
      game.goals.to_i
    end
    max_game.goals.to_i
  end

  def fewest_goals_scored(team_id) #Katya
    min_game = find_teams(team_id).min_by do |game|
      game.goals.to_i
    end
    min_game.goals.to_i
  end

  def favorite_opponent(team_id) #Katya
    favorite = calculate_team_statistics(team_id).min_by do |team, stats|
      (stats[:wins].to_f / stats[:games].to_f) * 100
    end
    team_name = find_team_name(favorite[0])
    team_name
  end

  def rival(team_id) #Katya
    rival = calculate_team_statistics(team_id).max_by do |team, stats|
      (stats[:wins].to_f / stats[:games].to_f) * 100
    end
    team_name = find_team_name(rival[0])
    team_name
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
    opponents = {}
    opponent_stats = calculate_team_statistics(team_id) 
    opponent_stats.each do |team, stats|
      opponents[find_team_name(team)] = (stats[:wins].to_f / stats[:games].to_f) * 100
    end
    opponents
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
      #Find all game_ids for this season
      season_game_ids = []
      @games.each do |game|
        if game.season == season
          season_game_ids << game.game_id
        end
      end

      #Filter game_team records based on season
      season_games = team_games.select do |game|
        season_game_ids.include?(game.game_id)
      end

      #separate regular/postseason games
      regular_games = []
      postseason_games = []

      season_games.each do |game|
        if find_game_type(game.game_id) == "Regular Season"
          regular_games << game
        else
          postseason_games << game
        end
      end

      summary[season] = {
        "regular_season" => calculate_season_stats(regular_games, team_id),
        "postseason" => calculate_season_stats(postseason_games, team_id)
      }
    
    end

    summary
  end
end