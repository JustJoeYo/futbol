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
  game_id = row[:game_id]
  season = row[:season]
  type = row[:type]
  date_time = row[:date_time]
  away_team_id = row[:away_team_id]
  home_team_id = row[:home_team_id]
  away_goals = row[:away_goals]
  home_goals = row[:home_goals]
  venue = row[:venue]
  venue_link = row[:venue_link]

  game = Game.new(game_id,season,type,date_time,away_team_id,away_goals,home_goals,venue,venue_link)
end

CSV.foreach('./data/game_teams.csv',headers: true, header_converters: :symbol) do |row|
  game_id = row[:game_id]
  team_id = row[:team_id]
  hoa = row[:hoa]
  result = row[:result]
  settled_in = row[:settled_in]
  head_coach = row[:head_coach]
  goals = row[:goals]
  shots = row[:shots]
  tackles = row[:tackles]
  pim = row[:pim]
  power_play_opportunities = row[:powerplayopportunities]
  power_play_goals = row[:powerplaygoals]
  face_off_win_percentage = row[:faceoffwinpercentage]
  giveaways = row[:giveaways]
  takeaways = row[:takeaways]

  game_teams = GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,power_play_opportunities,power_play_goals,face_off_win_percentage,giveaways,takeaways)
end

CSV.foreach('./data/teams.csv',headers: true, header_converters: :symbol) do |row|
  team_id = row[:team_id]
  franchise_id = row[:franchiseid]
  team_name = row[:teamname]
  abbreviation = row[:abbreviation]
  stadium = row[:stadium]
  link = row[:link]

  teams = Team.new(team_id,franchise_id,team_name,abbreviation,stadium,link)
end

#require 'pry'; binding.pry