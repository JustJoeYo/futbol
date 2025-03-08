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
  def find_teams(team_id) #makes an array of rows that have a certain team_id
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
  def find_games(team_id)
    game_id_array = find_teams(team_id).map {|game| game.game_id} #takes the array of team_id rows and transforms to create array of just game_id's
    
    @game_teams.find_all do |games|
      game_id_array.include?(games.game_id) #find the rows from the whole data set that have the same game_id as any game_id in the game_id_array
    end
  end

  #helper method three
  def group_teams(team_id) 
    grouped_hash = find_games(team_id).group_by do |row|
      row.team_id
    end
    grouped_hash.delete(team_id) #so we can just caclulate the opponents win percentages
    grouped_hash #this method is returning a nested hash of only the opponents rows, grouped by team_id 
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