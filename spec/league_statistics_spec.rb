require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe LeagueStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)

        @team_path = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
        @league_statistics = LeagueStatistics.new(@team_path)
      end

    describe '#initialize' do
        it 'exists' do

            expect(@league_statistics).to be_a(LeagueStatistics)
        end
    end

    describe '#count_of_teams' do
        it 'returns the total number of teams' do

            expect(@league_statistics.count_of_teams).to eq(32)
        end
    end

    describe '#best_offense' do #May want to stub
        it 'returns the team with the highest average goals scored per game' do

            allow(@league_statistics).to receive(:best_offense).and_return("FC Cincinnati")
            expect(@league_statistics.best_offense).to_eq("FC Cincinnati")
        end
    end

    describe '#worst_offense' do
        it 'returns the team with the lowest average goals scored per game' do

            allow(@league_statistics).to receive(:worst_offense).and_return("Chicago Fire")
            expect(@league_statistics.worst_offense).to_eq("Chicago Fire")
        end
    end

    describe '#highest_scoring_visitor' do
        it 'returns the team with the highest average score per game when away' do

            allow(@league_statistics).to receive(:highest_scoring_visitor).and_return("LA Galaxy")
            expect(@league_statistics.highest_scoring_visitor).to eq("LA Galaxy")
        end
    end
end