require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe LeagueStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)

        @team_path = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
        @game_teams = CSV.read('./data/game_teams_spec.csv', headers: true, header_converters: :symbol)

        @league_statistics = LeagueStatistics.new(@team_path, @game_teams)
      end

    describe '#initialize' do
        it 'exists' do

            expect(@league_statistics).to be_a(LeagueStatistics)
        end

        it '#attributes' do

            expect(@league_statistics.teams).not_to be_empty
            expect(@league_statistics.game_teams).not_to be_empty
        end
    end

    describe '#count_of_teams' do
        it 'returns the total number of teams' do

            expect(@league_statistics.count_of_teams).to eq(32)
        end
    end

    describe '#best_offense' do #May want to stub
        it 'returns the team with the highest average goals scored per game' do

            expect(@league_statistics.best_offense).to eq('FC Dallas') # From fixture
        end
    end

    describe '#worst_offense' do
        xit 'returns the team with the lowest average goals scored per game' do

            expect(@league_statistics.worst_offense).to_eq("Houston Dynamo") # From fixture
        end
    end

    describe '#highest_scoring_visitor' do
        xit 'returns the team with the highest average score per game when away' do

            expect(@league_statistics.highest_scoring_visitor).to eq("Houston Dynamo")
        end
    end

    describe '#highest_scoring_home_team' do
        xit 'returns the team with the highest average score per game when at home' do

            expect(@league_statistics.highest_scoring_home_team).to eq('FC Dallas')
        end
    end

    describe '#lowest_scoring_visitor' do
        xit 'returns the team with the lowest average score per game when away' do

            expect(@league_statistics.lowest_scoring_visitor).to eq('Houston Dynamo')
        end
    end

    describe '#lowest_scoring_home_team' do
        xit 'returns the team with the lowest average score per game when at home' do

            expect(@league_statistics.lowest_scoring_home_team).to eq('FC Dallas')
        end
    end

    # Add in helper method tests as needed
end