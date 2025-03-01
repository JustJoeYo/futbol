require 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
  end

RSpec.describe SeasonStatistics do
    before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)

        @game_teams_path = CSV.read('./data/game_team_fixture.csv', headers: true, header_converters: :symbol)
        @games_path = CSV.read('./data/games.csv', headers: true, header_converters: :symbol)

        @season_statistics = SeasonStatistics.new(@game_teams_path,@games_path)

        #binding.pry
        
      end
    describe 'initialization' do
        it '#initialize' do
            expect(@season_statistics).to be_an_instance_of(SeasonStatistics)
        end
        it '#attributes' do
            expect(@season_statistics.game_teams).not_to be_empty
            expect(@season_statistics.games).not_to be_empty
        end
    end
    describe 'instance methods' do
        it 'has a winningest_coach' do
            #expect(@season_statistics.winningest_coach())
        end

        it 'has a worst coach' do

        end

        it 'has a most accurate team' do

        end

        it 'has a least accurate team' do

        end

        it 'has most tackles' do

        end

        it 'has fewest tackles' do

        end
    end
end