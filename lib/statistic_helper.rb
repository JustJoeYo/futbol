module StatisticHelper
  # Define all the helper methods here (primarily calculations etc, this is just a demo of usage)

  # Example helper method to find a team name by team_id
  def team_name(teams, team_id)
    team = teams.find { |row| row[:team_id].to_s == team_id.to_s }
    team[:teamname]
  end

  # Add more helper methods as needed
end