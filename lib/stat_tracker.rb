require 'csv'  # Requires the CSV library to handle CSV file operations
require './lib/season_statistics'

class StatTracker
  attr_reader :games, :teams, :game_teams, :season_statistics  # Defines getter methods for games, teams, and game_teams

  # Initializes a new instance of StatTracker with games, teams, and game_teams data
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @season_statistics = SeasonStatistics.new(game_teams)
  end

  # Class method to create a new instance of StatTracker from CSV files
  def self.from_csv(locations)
    # Reads the games CSV file and converts headers to symbols
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    # Reads the teams CSV file and converts headers to symbols
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    # Reads the game_teams CSV file and converts headers to symbols
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    
    # Creates and returns a new instance of StatTracker with the read data
    self.new(games, teams, game_teams)
  end

  # Game Statistics
  def highest_total_score
    
  end

  def lowest_total_score
    
  end

  def percentage_home_wins
    
  end

  def percentage_visitor_wins
    
  end

  def percentage_ties
     
  end

  def count_of_games_by_season
    
  end

  def average_goals_per_game
    
  end

  def average_goals_by_season
    
  end

  # League Statistics
  def count_of_teams
    
  end

  def best_offense
    
  end

  def worst_offense
    
  end

  def highest_scoring_visitor
     
  end

  def highest_scoring_home_team
    
  end

  def lowest_scoring_visitor
    
  end

  def lowest_scoring_home_team
    
  end

  # Season Statistics
  def winningest_coach(season_id)
    
  end

  def worst_coach(season_id)
    
  end

  def most_accurate_team(season_id)
    
  end

  def least_accurate_team(season_id)
    
  end

  def most_tackles(season_id)
    
  end

  def fewest_tackles(season_id)
    
  end
end