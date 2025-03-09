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
    
  end

  def worst_loss(team_id) #Andrew
    
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
    
  end
end