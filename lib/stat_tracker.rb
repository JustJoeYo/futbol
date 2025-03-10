require 'csv'  # Requires the CSV library to handle CSV file operations
require_relative 'game_statistics'
require_relative 'season_statistics'
require_relative 'league_statistics'
require_relative 'team_statistics'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game_statistics, :season_statistics, :league_statistics, :team_statistics

  # Initializes a new instance of StatTracker with games, teams, and game_teams data
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_statistics = GameStatistics.new(games)
    @season_statistics = SeasonStatistics.new(game_teams,games,teams)
    @league_statistics = LeagueStatistics.new(games, teams, game_teams)
    @team_statistics = TeamStatistics.new(teams,games,game_teams)
  end

  # Class method to create a new instance of StatTracker from CSV files
  def self.from_csv(locations)
    # Reads the games CSV file and converts headers to symbols
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    # Reads the teams CSV file and converts headers to symbols
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    # Reads the game_teams CSV file and converts headers to symbols
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }
    
    # Creates and returns a new instance of StatTracker with the read data
    self.new(games, teams, game_teams)
  end

  #Game Statistics
  def highest_total_score
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    @game_statistics.percentage_ties
  end

  def count_of_games_by_season
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  #League Statistics
  def count_of_teams
    @league_statistics.count_of_teams
  end
  def best_offense
    @league_statistics.best_offense
  end
  def worst_offense
    @league_statistics.worst_offense
  end
  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end
  def highest_scoring_home_team
    @league_statistics.highest_scoring_home_team
  end
  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end
  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
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

  #Team Statistics
  def most_goals_scored(team_id)
    @team_statistics.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_statistics.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_statistics.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_statistics.rival(team_id)
  end

  def head_to_head(team_id)
    @team_statistics.head_to_head(team_id)
  end

  def biggest_team_blowout
    @team_statistics.biggest_team_blowout(team_id)
  end

  def worst_loss(team_id)
    @team_statistics.worst_loss(team_id)
  end

  def seasonal_summary(team_id)
    @team_statistics.seasonal_summary(team_id)
  end
end