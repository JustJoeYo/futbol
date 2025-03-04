require 'csv'  # Requires the CSV library to handle CSV file operations
require_relative 'game_statistics'
require_relative 'season_statistics'
require_relative 'league_statistics'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game_statistics, :season_statistics, :league_statistics

  # Initializes a new instance of StatTracker with games, teams, and game_teams data
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_statistics = GameStatistics.new(games)
    @season_statistics = SeasonStatistics.new(game_teams,games,teams)
    @league_statistics = LeagueStatistics.new(games, teams, game_teams)
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

  #Season Statistics
  def winningest_coach(season_id)
    @season_statistics.winningest_coach(season_id)
  end
  def worst_coach(season_id)
    @season_statistics.worst_coach(season_id)
  end
  def most_accurate_team(season_id)
    @season_statistics.most_accurate_team(season_id)
  end
  def least_accurate_team(season_id)
    @season_statistics.least_accurate_team(season_id)
  end
  def most_tackles(season_id)
    @season_statistics.most_tackles(season_id)
  end
  def fewest_tackles(season_id)
    @season_statistics.fewest_tackles(season_id)
  end

  #League Statistics
  
end