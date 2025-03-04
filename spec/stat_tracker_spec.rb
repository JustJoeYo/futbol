require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
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

  describe 'initialization' do
    it '#initialize' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
    end

    it '#attributes' do
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
      expect(@StatTracker.game_statistics).to be_an_instance_of(GameStatistics) # sanity checking for the instance of the class's
      expect(@StatTracker.league_statistics).to be_an_instance_of(LeagueStatistics)
      expect(@StatTracker.season_statistics).to be_an_instance_of(SeasonStatistics)
    end
  end

  # Placeholder for instance methods tests
  describe 'instance methods' do

    describe 'Game Statistics' do

    end
    
    describe 'League Statistics' do
      it '#count_of_teams' do
        expect(@stat_tracker.count_of_teams).to eq 32
      end

      it '#best_offense' do
        expect(@stat_tracker.best_offense).to eq 'FC Dallas'
      end

      it '#worst_offense' do
        expect(@stat_tracker.worst_offense).to eq 'Houston Dynamo'
      end

      it '#highest_scoring_visitor' do
        expect(@stat_tracker.highest_scoring_visitor).to eq 'FC Dallas'
      end

      it '#highest_scoring_home_team' do
        expect(@stat_tracker.highest_scoring_home_team).to eq 'FC Dallas'
      end

      it '#lowest_scoring_visitor' do
        expect(@stat_tracker.lowest_scoring_visitor).to eq 'Houston Dynamo'
      end

      it '#lowest_scoring_home_team' do
        expect(@stat_tracker.lowest_scoring_home_team).to eq 'Houston Dynamo'
      end
    end

    describe 'Season Statistics' do

    end
  end

  # class methods only (keyword 'self')
  describe 'class methods' do
    it '::from_csv' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
    end
  end
end