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
  def find_games(team_id) #makes an array of rows that have a certain team_id
    @game_teams.find_all do |game|
      team_id == game.team_id
    end
  end

  def most_goals_scored(team_id) #Katya
    max_game = find_games(team_id).max_by do |game|
      game.goals.to_i
    end
    max_game.goals.to_i
  end

  def fewest_goals_scored(team_id) #Katya
    min_game = find_games(team_id).min_by do |game|
      game.goals.to_i
    end
    min_game.goals.to_i
  end

  #helper method two
  def opponent_games(team_id)
    opponent = @game_teams.find_all do |game|
      team_id != game.team_id
    end
    #binding.pry
  end

  #helper method three
  def opponent_stats(team_id)
    stats = {}
    opponent_games(team_id).each do |game| #iterates through each row 
      if stats[game.team_id].nil?
        stats[game.team_id] = {wins: 0, games: 0}
      end
      stats[game.team_id][:games] += 1
      if game.result == "WIN"
        stats[game.team_id][:wins] += 1
      end
    end
    stats
    #binding.pry
  end

  def favorite_opponent(team_id) #Katya
    worst_team = opponent_stats(team_id).min_by do |team_id,stats|
      (stats[:wins].to_f/stats[:games].to_f) * 100
    end
    binding.pry
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