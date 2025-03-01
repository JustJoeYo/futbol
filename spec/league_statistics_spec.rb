require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe LeagueStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)

        @games = CSV.read('./data/games_spec.csv', headers: true, header_converters: :symbol)
        @team_path = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
        @game_teams = CSV.read('./data/game_teams_spec.csv', headers: true, header_converters: :symbol)

        @league_statistics = LeagueStatistics.new(@team_path, @game_teams)
      end

    describe '#initialize' do
        it 'exists' do

            expect(@league_statistics).to be_a(LeagueStatistics)
        end

        it '#attributes' do

            expect(@league_statistics.games).not_to be_empty
            expect(@league_statistics.teams).not_to be_empty
            expect(@league_statistics.game_teams).not_to be_empty
        end
    end

    describe '#team_name' do
        it 'returns the correct team name when given a valid team ID' do
            
            expect(@league_statistics.team_name('6')).to eq('FC Dallas')
            expect(@league_statistics.team_name('3')).to eq('Houston Dynamo')
        end

        it 'returns "Unknown Team" when given an invalid team ID' do
            
            expect(@league_statistics.team_name('99999')).to eq('Unknown Team') # Fake ID
        end
    end

    describe '#calculate_avg-goals' do
        it 'correctly calculates average goals per game for a team' do

            expect(@league_statistics.calculate_avg_goals('6')).to eq(3.0)
            expect(@league_statistics.calculate_avg_goals('3')).to eq(1.67) #Rounded
        end

        it 'returns 0.0 if the team has played no games' do

            expect(@league_statistics.calculate_avg_goals('99999')).to eq(0.0) #Fake ID
        end
    end

    describe '#team_avg_goals_by_hoa' do
        it 'correctly calculates the avg goals per game for home teams' do
            
            expected_home_avg = {
                "FC Dallas" => 3.0, 
                "Houston Dynamo" => 1.5 
            }

            expect(@league_statistics.team_avg_goals_by_hoa('home')).to eq(expected_home_avg)
        end

        it 'correctly calculates the avg goals per game for the away teams' do
            
            expected_away_avg = {
                "Houston Dynamo" => 2.0, 
                "FC Dallas" => 2.0
            }

            expect(@league_statistics.team_avg_goals_by_hoa('away')).to eq(expected_away_avg)
        end

        it 'returns an empty hash if no teams have played in the given category' documentation

            allow(@league_statistics).to receive(:@games).and_return([]) #trying to stub no games played

            expect(@league_statistics.team_avg_goals_by_hoa('home')).to eq({})
            expect(@league_statistics.team_avg_goals_by_hoa('away')).to eq({})
        end
    end

    describe '#count_of_teams' do
        it 'returns the total number of teams' do

            expect(@league_statistics.count_of_teams).to eq(32)
        end
    end

    describe '#best_offense' do #May want to stub
        xit 'returns the team with the highest average goals scored per game' do

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
end