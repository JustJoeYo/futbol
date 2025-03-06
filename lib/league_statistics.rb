require_relative 'statistic_helper'

class LeagueStatistics
    include StatisticHelper
    attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def count_of_teams # Counts number of teams in the csv
    @teams.size
  end

  def best_offense
    highest_avg_team(:max_by)
  end

  def worst_offense
    lowest_avg_team(:min_by)
  end

  def highest_scoring_visitor
    highest_avg_team_by_hoa('away', :max_by)
  end

  def highest_scoring_home_team
    highest_avg_team_by_hoa('home', :max_by)
  end

  def lowest_scoring_visitor
    highest_avg_team_by_hoa('away', :min_by)
  end

  def lowest_scoring_home_team
    highest_avg_team_by_hoa('home', :min_by)
  end
end