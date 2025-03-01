require 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
  end

RSpec.describe SeasonStatistics do
    before(:each) do 

        @game_teams_path = CSV.read('./data/game_team_fixture.csv', headers: true, header_converters: :symbol)
        @games_path = CSV.read('./data/games_fixture.csv', headers: true, header_converters: :symbol)

        @season_statistics = SeasonStatistics.new(@game_teams_path,@games_path)
        
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
            expect(@season_statistics.winningest_coach("20122013")).to eq("Claude Julien")
        end

        it 'has a worst coach' do
            expect(@season_statistics.worst_coach("20122013")).to eq("John Tortorella")
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