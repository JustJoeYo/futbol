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
        it 'has an array of games' do
            @season_statistics.games_in_season("20152016")
            
            expected_result_array = [
                {
                  game_id: "2015030141",
                  team_id: "3",
                  hoa: "away",
                  result: "LOSS",
                  settled_in: "REG",
                  head_coach: "Alain Vigneault",
                  goals: "2",
                  shots: "9",
                  tackles: "50",
                  pim: "10",
                  powerplayopportunities: "5",
                  powerplaygoals: "1",
                  faceoffwinpercentage: "48.5",
                  giveaways: "2",
                  takeaways: "3"
                },
                {
                  game_id: "2015030141",
                  team_id: "5",
                  hoa: "home",
                  result: "WIN",
                  settled_in: "REG",
                  head_coach: "Mike Sullivan",
                  goals: "3",
                  shots: "7",
                  tackles: "35",
                  pim: "10",
                  powerplayopportunities: "5",
                  powerplaygoals: "1",
                  faceoffwinpercentage: "51.5",
                  giveaways: "10",
                  takeaways: "4"
                },
                {
                  game_id: "2015030142",
                  team_id: "3",
                  hoa: "away",
                  result: "TIE",
                  settled_in: "REG",
                  head_coach: "Alain Vigneault",
                  goals: "2",
                  shots: "7",
                  tackles: "57",
                  pim: "19",
                  powerplayopportunities: "3",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "44.3",
                  giveaways: "3",
                  takeaways: "3"
                },
                {
                  game_id: "2015030142",
                  team_id: "5",
                  hoa: "home",
                  result: "TIE",
                  settled_in: "REG",
                  head_coach: "Mike Sullivan",
                  goals: "2",
                  shots: "7",
                  tackles: "25",
                  pim: "15",
                  powerplayopportunities: "5",
                  powerplaygoals: "2",
                  faceoffwinpercentage: "55.7",
                  giveaways: "10",
                  takeaways: "2"
                }
              ]

            expect(@season_statistics.games_in_season("20152016")).to eq(expected_result_array)
        end
        it 'has a winningest_coach' do
            expect(@season_statistics.winningest_coach("20122013")).to eq("Claude Julien")
        end

        it 'has a worst coach' do
            #expect(@season_statistics.worst_coach("20122013")).to eq("John Tortorella")
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