module StatisticHelper
  # Define all the helper methods here (primarily calculations etc, this is just a demo of usage)

  # Example helper method to find a team name by team_id
  # def find_team_name(teams, team_id)
  #   team = teams.find { |row| row[:team_id].to_s == team_id.to_s }
  #   team[:teamname]
  # end
  #Game Statistics
  # Helper method to calculate the percentage of games that meet a certain condition (yield)
  def calculate_percentage
    count = @games.count { |game| yield(game) }
    (count.to_f / @games.size).round(2)
  end
  # Helper method to find the highest score in the games data
  def highest_score
    @games.map { |game| game.home_goals.to_i + game.away_goals.to_i }.max
  end
  # Helper method to find the lowest score in the games data
  def lowest_score
    @games.map { |game| game.home_goals.to_i + game.away_goals.to_i }.min
  end

  #League Statistics Helpers

  def team_name(team_id) # Finds the team name based on the team_id
    team_names = @teams.find do |team|
      team.team_id == team_id
    end
    if team_names.nil?
      'Unknown Team'
    else
      team_names.team_name
    end
  end

  def calculate_avg_goals(team_id, hoa = nil) # Adding hoa argument to handle separation of values logic
    # Step 1, find all games where the team played (home or away)
    games_played = @games.select do |game|
      if hoa == 'home'
        game[:home_team_id] == team_id # Only home games
      elsif hoa == 'away'
        game[:away_team_id] == team_id # Only away games
      else
        game[:home_team_id] == team_id || game[:away_team_id] == team_id # All games
      end
    end

    # Step 2, sum all goals scored by this team in those games
    total_goals = games_played.sum do |game| # Loops through the games_played.
      if game[:home_team_id] == team_id
        game[:home_goals].to_i # Add home goals if the team was the home team
      else
        game[:away_goals].to_i # Add away goals if the team was the away team
      end
    end

    # Step 3, count the number of games the team played
    total_games = games_played.size # Counts the total number of games played by the team

    # Step 4, calculate average goals per game, avoiding zero division
    if total_games.zero? # Guard against zero
      0.0
    else
      (total_goals.to_f / total_games).round(2) # Rounding to handle large decimals. ex 2/3 = .67
    end
  end

  def team_avg_goals_by_hoa(hoa)
    return {} if @games.empty? # Guard against empty

    # Step 1, filter the games by home/away
    filtered_games = @games.select do |game|
      if hoa == 'home'
        game[:home_team_id] != nil # Ensures only home teams are selected
      else
        game[:away_team_id] != nil # Ensures only away teams are selected
      end
    end

    # Step 2, group the filtered games by team ID
    grouped_games = {}

    filtered_games.each do |game|
      team_id = hoa == 'home' ? game[:home_team_id] : game[:away_team_id] # Ternary for if else

      grouped_games[team_id] ||= []
      grouped_games[team_id] << game
    end

    # Step 3, convert team ids to team names
    team_games = {}

    grouped_games.each do |team_id, games|
      team_name_string = team_name(team_id)

      team_games[team_name_string] = games
    end

    # Step 4, Calculate average goals per game for each team
    team_avg_goals = {}

    team_games.each do |team_name, games|
      team_id = hoa == 'home' ? games.first[:home_team_id] : games.first[:away_team_id] # Ternary for if else
      team_avg_goals[team_name] = calculate_avg_goals(team_id, hoa)
    end

    team_avg_goals
  end

  def highest_avg_team(method)
    avg_goals = @teams.map { |team| [team_name(team[:team_id]), calculate_avg_goals(team[:team_id])] }.to_h

    avg_goals.send(method) { |_, avg| avg }[0]
  end

  def lowest_avg_team(method)
    avg_goals = @teams.map { |team| [team_name(team[:team_id]), calculate_avg_goals(team[:team_id])] }.to_h

    # Removing teams with 0.0 from the return
    filtered_avg = avg_goals.reject { |_, avg| avg == 0.0 }

    return "No teams have played games" if filtered_avg.empty? # Return this if no teams have played games

    filtered_avg.send(method) { |_, avg| avg }[0]
  end

  def highest_avg_team_by_hoa(hoa, method)
    goals = team_avg_goals_by_hoa(hoa)

    goals.send(method) { |_, avg| avg }[0]
  end

  #season statistic helpers
  # Helper method one - makes an array of all the games in a season
  def games_in_season(season_id)
    game_ids = []
    @games.each do |game|
      if game.season == season_id
        game_ids << game.game_id
      end
    end
    season_games = []
    @game_teams.find_all do |games|
      if game_ids.include?(games.game_id)
        season_games << games
      end
    end
    season_games
  end

  # Helper method two - makes a nested array of the data grouped by coach
  def group_by_coach(season_id)
    games = games_in_season(season_id)

    grouped_arrays = games.group_by do |row|
      row.head_coach
    end.values
    grouped_arrays
  end

  # Helper method three - makes a nested array grouped by team_id
  def group_by_team(season_id)
    games = games_in_season(season_id)

    grouped_arrays = games.group_by do |row|
      row.team_id
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
        if row.result == "WIN"
          wins += 1
        end
        games += 1
        coach_stats[row.head_coach] = { wins: wins, games: games }
      end
    end
    coach_stats
  end

  # Helper method five
  def calculate_team_stats(season_id, *stats)
    grouped_array = group_by_team(season_id)
    team_stats = {}

    grouped_array.each do |team_array|
      team_id = team_array.first.team_id
      team_stats[team_id] ||= {}

      stats.each do |stat|
        total_stat = team_array.sum { |row| row.send(stat).to_i }
        team_stats[team_id][stat] = total_stat
      end
    end
    team_stats
  end

  # Helper method six
  def find_team_name(team_id)
    team_row = @teams.find do |row|
      row.team_id.to_s == team_id.to_s
    end
    team_row.team_name
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