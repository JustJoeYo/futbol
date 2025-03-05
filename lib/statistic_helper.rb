module StatisticHelper
  # Define all the helper methods here (primarily calculations etc, this is just a demo of usage)

  # Example helper method to find a team name by team_id
  # def find_team_name(teams, team_id)
  #   team = teams.find { |row| row[:team_id].to_s == team_id.to_s }
  #   team[:teamname]
  # end

  # Helper method to calculate the percentage of games that meet a certain condition (yield)
  def calculate_percentage
    count = @games.count { |game| yield(game) }
    (count.to_f / @games.size).round(2)
  end

  # Helper method to find the highest score in the games data
  def highest_score
    @games.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }.max
  end

  # Helper method to find the lowest score in the games data
  def lowest_score
    @games.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }.min
  end

  #season statistic helpers
  # Helper method one - makes an array of all the games in a season
  def games_in_season(season_id)
    game_ids = []
    @games.each do |game|
      if game[:season] == season_id
        game_ids << game[:game_id]
      end
    end

    season_games = []
    @game_teams.find_all do |games|
      if game_ids.include?(games[:game_id])
        season_games << games.to_h
      end
    end
    season_games
  end

  # Helper method two - makes a nested array of the data grouped by coach
  def group_by_coach(season_id)
    games = games_in_season(season_id)

    grouped_arrays = games.group_by do |row|
      row[:head_coach]
    end.values
    grouped_arrays
  end

  # Helper method three - makes a nested array grouped by team_id
  def group_by_team(season_id)
    games = games_in_season(season_id)

    grouped_arrays = games.group_by do |row|
      row[:team_id]
    end.values
    grouped_arrays
  end

  # Helper method four
  def calculate_coach_stats(season_id)
    grouped_array = group_by_coach(season_id)

    coach_stats = {}
    grouped_array.each do |coach_array|
      wins = 0
      games = 0
      coach_array.map do |row|
        if row[:result] == "WIN"
          wins += 1
        end
        games += 1
        coach_stats[row[:head_coach]] = { wins: wins, games: games }
      end
    end
    coach_stats
  end

  # Helper method five
  def calculate_team_stats(season_id, *stats)
    grouped_array = group_by_team(season_id)
    team_stats = {}

    grouped_array.each do |team_array|
      team_id = team_array.first[:team_id]
      team_stats[team_id] ||= {}

      stats.each do |stat|
        total_stat = team_array.sum { |row| row[stat].to_i }
        team_stats[team_id][stat] = total_stat
      end
    end
    team_stats
  end

  # Helper method six
  def find_team_name(team_id)
    team_row = @teams.find do |row|
      row[:team_id].to_s == team_id.to_s
    end
    team_row[:teamname]
  end

  # Add more helper methods below and add a comment saying what it does.
end

# you can check my class out or look at this below
# this is how you would use this in your classes:



#require './lib/statistic_helper'

# class ExampleStatistics
#   include StatisticHelper # within the class in order to use the helper methods

#   # class methods here
# end
