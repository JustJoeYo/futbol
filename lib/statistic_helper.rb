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

  # Add more helper methods below and add a comment saying what it does.
end

# you can check my class out or look at this below
# this is how you would use this in your classes:



#require './lib/statistic_helper'

# class ExampleStatistics
#   include StatisticHelper # within the class in order to use the helper methods

#   # class methods here
# end