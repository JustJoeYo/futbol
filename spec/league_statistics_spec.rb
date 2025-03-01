require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe LeagueStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)
        @game_path = './data/games.csv'
        @team_path = './data/teams.csv'
        @game_teams_path = './data/game_teams.csv'
    
        @locations = {
          games: @game_path,
          teams: @team_path,
          game_teams: @game_teams_path
        }
    
        @StatTracker = StatTracker.from_csv(@locations)
      end

      
    end
end