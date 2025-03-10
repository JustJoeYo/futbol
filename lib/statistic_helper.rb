module StatisticHelper
  def calculate_percentage
    count = @games.count { |game| yield(game) }
    (count.to_f / @games.size).round(2)
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
        game.home_team_id == team_id # Only home games
      elsif hoa == 'away'
        game.away_team_id == team_id # Only away games
      else
        game.home_team_id == team_id || game.away_team_id == team_id # All games
      end
    end

    # Step 2, sum all goals scored by this team in those games
    total_goals = games_played.sum do |game| # Loops through the games_played.
      if game.home_team_id == team_id
        game.home_goals.to_i # Add home goals if the team was the home team
      else
        game.away_goals.to_i # Add away goals if the team was the away team
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
        game.home_team_id != nil # Ensures only home teams are selected
      else
        game.away_team_id != nil # Ensures only away teams are selected
      end
    end

    # Step 2, group the filtered games by team ID
    grouped_games = {}

    filtered_games.each do |game|
      team_id = hoa == 'home' ? game.home_team_id : game.away_team_id # Ternary for if else

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
      team_id = hoa == 'home' ? games.first.home_team_id : games.first.away_team_id # Ternary for if else
      team_avg_goals[team_name] = calculate_avg_goals(team_id, hoa)
    end

    team_avg_goals
  end

  def highest_avg_team(method)
    avg_goals = @teams.map { |team| [team_name(team.team_id), calculate_avg_goals(team.team_id)] }.to_h

    avg_goals.send(method) { |_, avg| avg }[0]
  end

  def lowest_avg_team(method)
    avg_goals = @teams.map { |team| [team_name(team.team_id), calculate_avg_goals(team.team_id)] }.to_h

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

    # Team statistics helpers
    def season_win_percentages(team_id)
      seasons = @games.map { |game| game.season }.uniq
      seasons.each_with_object({}) do |season, percentages|
        total_games = @game_teams.count { |game_team| game_team.team_id == team_id && season(game_team) == season }
        total_wins = @game_teams.count { |game_team| game_team.team_id == team_id && season(game_team) == season && game_team.result == "WIN" }
        percentages[season] = total_games.zero? ? 0 : (total_wins.to_f / total_games).round(2)
      end
    end
  
    def season(game_team)
      game = @games.find { |g| g.game_id == game_team.game_id }
      game.season
    end

    def find_teams(team_id) 
      @game_teams.find_all do |game|
        team_id == game.team_id
      end
    end
   
    def find_games(team_id)
      game_id_array = find_teams(team_id).map {|game| game.game_id} 
      
      @game_teams.find_all do |games|
        game_id_array.include?(games.game_id) 
      end
    end

    def group_teams(team_id) 
      grouped_hash = find_games(team_id).group_by do |row|
        row.team_id
      end
      grouped_hash.delete(team_id) 
      grouped_hash.values 
    end

    def calculate_team_statistics(team_id) 
      grouped_array = group_teams(team_id)
      team_stats = {}
      grouped_array.each do |team_array|
        wins = 0
        games = 0
        team_array.each do |row|
          if row.result == "WIN"
            wins += 1
          end
          games += 1
          team_stats[row.team_id] = { wins: wins, games: games }
          end
        end
        team_stats 
    end

    def games_involving_team(team_id) #finds all games involving team
      @game_teams.select do |game_team|
        game_team.team_id == team_id
      end
    end
  
    def find_season_by_game_id(game_id) #Finds the season for a given game_id
      game_record = @games.find do |game|
        game.game_id == game_id
      end
      game_record.season
    end
  
    def calculate_season_stats(games, team_id)
      return {
        win_percentage: 0.0,
        total_goals_scored: 0,
        total_goals_against: 0,
        average_goals_scored: 0.0,
        average_goals_against: 0.0
      } if games.empty? #Guard against zero
  
      total_games = games.size
  
      total_wins = 0
      total_goals_scored = 0
      total_goals_against = 0
  
      games.each do |game|
        if game.result == "WIN"
          total_wins += 1
        end
  
        total_goals_scored += game.goals.to_i
        total_goals_against += find_opponent_score(game, team_id)
      end
      #Hash creation
      {
        win_percentage: (total_wins.to_f / total_games).round(2),
        total_goals_scored: total_goals_scored,
        total_goals_against: total_goals_against,
        average_goals_scored: (total_goals_scored.to_f / total_games).round(2),
        average_goals_against: (total_goals_against.to_f / total_games).round(2)
      }
    end
  
    def find_game_type(game_id)
      game_record = @games.find do |game|
        game.game_id == game_id
      end
  
      game_record.type
    end
  
    def find_opponent_score(game, team_id) #Finds opponents goals from the game
      game_record = @games.find do |g| #Using g as game is an argument
        g.game_id == game.game_id
      end
  
      if game_record.home_team_id == team_id
        game_record.away_goals.to_i
      else
        game_record.home_goals.to_i
      end
    end
  
    def games_won_by_team(team_id) #finds all games where the team won
      @game_teams.select do |game|
        game.team_id == team_id && game.result == "WIN"
      end
    end
  
    def games_lost_by_team(team_id) #Finds all games where the team lost
      @game_teams.select do |game|
        game.team_id == team_id && game.result == "LOSS"
      end
    end
  
    def goal_difference(game, team_id) #Finds the goal differential
      game_record = @games.find do |g| #Using g instead of game due to game argument
        g.game_id == game.game_id
      end
  
      if game_record.home_team_id == team_id
        (game_record.home_goals.to_i - game_record.away_goals.to_i).abs
      elsif game_record.away_team_id == team_id
        (game_record.away_goals.to_i - game_record.home_goals.to_i).abs
      end
    end
end