require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = { # all locations of the csv files we need
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = Stat_Tracker.from_csv(locations) # create a new instance of StatTracker and call the from_csv method on it

CSV.foreach('./data/games.csv',headers: true, header_converters: :symbol) do |row|
  game_id = row[:game_id].to_i
  season = row[:season]
  type = row[:type]
  date_time = row[:date_time]
  away_team_id = row[:away_team_id]
  away_goals = row[:away_goals]
  home_goals = row[:home_goals]
  venue = row[:venue]
  venue_link = row[:venue_link]

  game = Game.new(game_id,season,type,date_time,away_team_id,away_goals,home_goals,venue,venue_link)
end

CSV.foreach('./data/game_teams.csv',headers: true, header_converters: :symbol) do |row|
  
end

require 'pry'; binding.pry