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
    team = @teams.find { |t| t.team_id == team_id } #couldn't use team so I used t here
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
  #helper method one
  def find_teams(team_id) 
    @game_teams.find_all do |game|
      team_id == game.team_id
    end
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

  #helper method two
  def find_games(team_id)
    game_id_array = find_teams(team_id).map {|game| game.game_id} 
    
    @game_teams.find_all do |games|
      game_id_array.include?(games.game_id) 
    end
  end

  #helper method three
  def group_teams(team_id) 
    grouped_hash = find_games(team_id).group_by do |row|
      row.team_id
    end
    grouped_hash.delete(team_id) 
    grouped_hash.values #this method is returning a nested array of only the opponents rows, grouped by team_id 
  end

  #helper method four
  def calculate_team_statistics(team_id) 
    grouped_array = group_teams(team_id)
    team_stats = {}
    grouped_array.each do |team_array|
      wins = 0
      games = 0
      team_array.each do |row|
        if row.result == "WIN"
          wins += 1
        end
        games += 1
        team_stats[row.team_id] = { wins: wins, games: games }
        end
      end
      team_stats 
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

    total_wins = 0
    total_goals_scored = 0
    total_goals_against = 0

    games.each do |game|
      if game.result == "WIN"
        total_wins += 1
      end

      total_goals_scored += game.goals.to_i
      total_goals_against += find_opponent_score(game, team_id)
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
      (game_record.home_goals.to_i - game_record.away_goals.to_i).abs
    elsif game_record.away_team_id == team_id
      (game_record.away_goals.to_i - game_record.home_goals.to_i).abs
    else
      0 #Edge case guard
    end
  end
end