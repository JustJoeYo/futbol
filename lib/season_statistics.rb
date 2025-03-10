require_relative 'statistic_helper'

class SeasonStatistics
  include StatisticHelper
  attr_reader :game_teams, :games, :teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def winningest_coach(season_id)
    coach_stats = calculate_coach_stats(season_id)

    best_coach = coach_stats.max_by do |coach, stats|
      (stats[:wins].to_f / stats[:games].to_f) * 100
    end

    best_coach[0]
  end

  def worst_coach(season_id)
    coach_stats = calculate_coach_stats(season_id)

    worst_coach = coach_stats.min_by do |coach, stats|
      (stats[:wins].to_f / stats[:games].to_f) * 100
    end
    worst_coach[0]
  end

  def most_accurate_team(season_id)
    team_stats = calculate_team_stats(season_id, :shots, :goals)

    most_accurate = team_stats.min_by do |team, stats| #lower ratio means more accurate
      stats[:shots].to_f / stats[:goals].to_f
    end

    team_name = find_team_name(most_accurate[0])
    team_name
  end

  def least_accurate_team(season_id)
    team_stats = calculate_team_stats(season_id, :shots, :goals)

    least_accurate = team_stats.max_by do |team, stats| #higher ratio means less accurate
      stats[:shots].to_f / stats[:goals].to_f
    end

    team_name = find_team_name(least_accurate[0])
    team_name
  end

  def most_tackles(season_id)
    team_stats = calculate_team_stats(season_id, :tackles)

    most_tackles = team_stats.max_by do |team, stats|
      stats[:tackles]
    end

    team_name = find_team_name(most_tackles[0])
    team_name
  end

  def fewest_tackles(season_id)
    team_stats = calculate_team_stats(season_id, :tackles)

    least_tackles = team_stats.min_by do |team, stats|
      stats[:tackles]
    end

    team_name = find_team_name(least_tackles[0])
    team_name
  end
end