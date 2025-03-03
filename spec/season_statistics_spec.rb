require 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
  end

RSpec.describe SeasonStatistics do
    before(:each) do 

        @game_teams_path = CSV.read('./data/game_team_fixture.csv', headers: true, header_converters: :symbol)
        @games_path = CSV.read('./data/games_fixture.csv', headers: true, header_converters: :symbol)
        @team_path = CSV.read('./data/teams.csv',headers:true, header_converters: :symbol)

        @season_statistics = SeasonStatistics.new(@game_teams_path,@games_path,@team_path)
        
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
        it 'can group the data set by coach' do
            expected_array = [[{ 
                                game_id: "2012030221", 
                                team_id: "3", 
                                hoa: "away", 
                                result: "LOSS", 
                                settled_in: "OT", 
                                head_coach: "John Tortorella", 
                                goals: "2", 
                                shots: "8", 
                                tackles: "44", 
                                pim: "8", 
                                powerplayopportunities: "3", 
                                powerplaygoals: "0", 
                                faceoffwinpercentage: "44.8", 
                                giveaways: "17", takeaways: "7" 
                                },
                                { 
                                game_id: "2012030222", 
                                team_id: "3", 
                                hoa: "away", 
                                result: "LOSS", 
                                settled_in: "REG", 
                                head_coach: "John Tortorella", 
                                goals: "2", 
                                shots: "9", 
                                tackles: "33", 
                                pim: "11", 
                                powerplayopportunities: "5", 
                                powerplaygoals: "0", 
                                faceoffwinpercentage: "51.7", 
                                giveaways: "1", 
                                takeaways: "4" 
                                }, 
                                { 
                                game_id: "2012030223", 
                                team_id: "3", 
                                hoa: "home", 
                                result: "LOSS", 
                                settled_in: "REG", 
                                head_coach: "John Tortorella", 
                                goals: "1", 
                                shots: "6", 
                                tackles: "37", 
                                pim: "2", 
                                powerplayopportunities: "2", 
                                powerplaygoals: "0", 
                                faceoffwinpercentage: "38.2", 
                                giveaways: "7", 
                                takeaways: "9" 
                                }], 
                                [{ 
                                game_id: "2012030221", 
                                team_id: "6", 
                                hoa: "home", 
                                result: "WIN", 
                                settled_in: "OT", 
                                head_coach: "Claude Julien", 
                                goals: "3", 
                                shots: "12", 
                                tackles: "51", 
                                pim: "6", 
                                powerplayopportunities: "4", 
                                powerplaygoals: "1", 
                                faceoffwinpercentage: "55.2", 
                                giveaways: "4", 
                                takeaways: "5" 
                                }, 
                                { 
                                game_id: "2012030222", 
                                team_id: "6", 
                                hoa: "home", 
                                result: "WIN", 
                                settled_in: "REG", 
                                head_coach: "Claude Julien", 
                                goals: "3", 
                                shots: "8", 
                                tackles: "36", 
                                pim: "19", 
                                powerplayopportunities: "1", 
                                powerplaygoals: "0", 
                                faceoffwinpercentage: "48.3", 
                                giveaways: "16", 
                                takeaways: "6" 
                                }, 
                                { 
                                game_id: "2012030223", 
                                team_id: "6", 
                                hoa: "away", 
                                result: "WIN", 
                                settled_in: "REG", 
                                head_coach: "Claude Julien", 
                                goals: "2", 
                                shots: "8", 
                                tackles: "28", 
                                pim: "6", 
                                powerplayopportunities: "0", 
                                powerplaygoals: "0", 
                                faceoffwinpercentage: "61.8", 
                                giveaways: "10", 
                                takeaways: "7" 
                                }, 
                                { 
                                game_id: "2012030224", 
                                team_id: "6", 
                                hoa: "away", 
                                result: "WIN", 
                                settled_in: "OT", 
                                head_coach: "Claude Julien", 
                                goals: "3", 
                                shots: "10", 
                                tackles: "24", 
                                pim: "8", 
                                powerplayopportunities: "4", 
                                powerplaygoals: "2", 
                                faceoffwinpercentage: "53.7", 
                                giveaways: "8", 
                                takeaways: "6" 
                                }]]
           
            expect(@season_statistics.group_by_coach("20122013")).to eq(expected_array)
        end
        it 'has a winningest_coach' do
            expected_result_array = [
                {
                  game_id: "2012030221",
                  team_id: "3",
                  hoa: "away",
                  result: "LOSS",
                  settled_in: "OT",
                  head_coach: "John Tortorella",
                  goals: "2",
                  shots: "8",
                  tackles: "44",
                  pim: "8",
                  powerplayopportunities: "3",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "44.8",
                  giveaways: "17",
                  takeaways: "7"
                },
                {
                  game_id: "2012030221",
                  team_id: "6",
                  hoa: "home",
                  result: "WIN",
                  settled_in: "OT",
                  head_coach: "Claude Julien",
                  goals: "3",
                  shots: "12",
                  tackles: "51",
                  pim: "6",
                  powerplayopportunities: "4",
                  powerplaygoals: "1",
                  faceoffwinpercentage: "55.2",
                  giveaways: "4",
                  takeaways: "5"
                },
                {
                  game_id: "2012030222",
                  team_id: "3",
                  hoa: "away",
                  result: "LOSS",
                  settled_in: "REG",
                  head_coach: "John Tortorella",
                  goals: "2",
                  shots: "9",
                  tackles: "33",
                  pim: "11",
                  powerplayopportunities: "5",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "51.7",
                  giveaways: "1",
                  takeaways: "4"
                },
                {
                  game_id: "2012030222",
                  team_id: "6",
                  hoa: "home",
                  result: "WIN",
                  settled_in: "REG",
                  head_coach: "Claude Julien",
                  goals: "3",
                  shots: "8",
                  tackles: "36",
                  pim: "19",
                  powerplayopportunities: "1",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "48.3",
                  giveaways: "16",
                  takeaways: "6"
                },
                {
                  game_id: "2012030223",
                  team_id: "6",
                  hoa: "away",
                  result: "WIN",
                  settled_in: "REG",
                  head_coach: "Claude Julien",
                  goals: "2",
                  shots: "8",
                  tackles: "28",
                  pim: "6",
                  powerplayopportunities: "0",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "61.8",
                  giveaways: "10",
                  takeaways: "7"
                },
                {
                  game_id: "2012030223",
                  team_id: "3",
                  hoa: "home",
                  result: "LOSS",
                  settled_in: "REG",
                  head_coach: "John Tortorella",
                  goals: "1",
                  shots: "6",
                  tackles: "37",
                  pim: "2",
                  powerplayopportunities: "2",
                  powerplaygoals: "0",
                  faceoffwinpercentage: "38.2",
                  giveaways: "7",
                  takeaways: "9"
                },
                {
                  game_id: "2012030224",
                  team_id: "6",
                  hoa: "away",
                  result: "WIN",
                  settled_in: "OT",
                  head_coach: "Claude Julien",
                  goals: "3",
                  shots: "10",
                  tackles: "24",
                  pim: "8",
                  powerplayopportunities: "4",
                  powerplaygoals: "2",
                  faceoffwinpercentage: "53.7",
                  giveaways: "8",
                  takeaways: "6"
                }]

            expect(@season_statistics.games_in_season("20122013")).to eq(expected_result_array)
              

            expect(@season_statistics.winningest_coach("20122013")).to eq("Claude Julien")

            expect(@season_statistics.winningest_coach("20142015")).to eq("Jon Cooper")
        end

        it 'has a worst coach' do

            expect(@season_statistics.worst_coach("20122013")).to eq("John Tortorella")
            expect(@season_statistics.worst_coach("20142015")).to eq("Joel Quenneville")
    
        end
        it 'can group by team id' do
            expected_array = [[{
                    game_id: "2012030221",
                    team_id: "3",
                    hoa: "away",
                    result: "LOSS",
                    settled_in: "OT",
                    head_coach: "John Tortorella",
                    goals: "2",
                    shots: "8",
                    tackles: "44",
                    pim: "8",
                    powerplayopportunities: "3",
                    powerplaygoals: "0",
                    faceoffwinpercentage: "44.8",
                    giveaways: "17",
                    takeaways: "7"
                  },
                  {
                    game_id: "2012030222",
                    team_id: "3",
                    hoa: "away",
                    result: "LOSS",
                    settled_in: "REG",
                    head_coach: "John Tortorella",
                    goals: "2",
                    shots: "9",
                    tackles: "33",
                    pim: "11",
                    powerplayopportunities: "5",
                    powerplaygoals: "0",
                    faceoffwinpercentage: "51.7",
                    giveaways: "1",
                    takeaways: "4"
                  },
                  {
                    game_id: "2012030223",
                    team_id: "3",
                    hoa: "home",
                    result: "LOSS",
                    settled_in: "REG",
                    head_coach: "John Tortorella",
                    goals: "1",
                    shots: "6",
                    tackles: "37",
                    pim: "2",
                    powerplayopportunities: "2",
                    powerplaygoals: "0",
                    faceoffwinpercentage: "38.2",
                    giveaways: "7",
                    takeaways: "9"
                  }],
                  [{
                    game_id: "2012030221",
                    team_id: "6",
                    hoa: "home",
                    result: "WIN",
                    settled_in: "OT",
                    head_coach: "Claude Julien",
                    goals: "3",
                    shots: "12",
                    tackles: "51",
                    pim: "6",
                    powerplayopportunities: "4",
                    powerplaygoals: "1",
                    faceoffwinpercentage: "55.2",
                    giveaways: "4",
                    takeaways: "5"
                  },
                  {
                    game_id: "2012030222",
                    team_id: "6",
                    hoa: "home",
                    result: "WIN",
                    settled_in: "REG",
                    head_coach: "Claude Julien",
                    goals: "3",
                    shots: "8",
                    tackles: "36",
                    pim: "19",
                    powerplayopportunities: "1",
                    powerplaygoals: "0",
                    faceoffwinpercentage: "48.3",
                    giveaways: "16",
                    takeaways: "6"
                  },
                  {
                    game_id: "2012030223",
                    team_id: "6",
                    hoa: "away",
                    result: "WIN",
                    settled_in: "REG",
                    head_coach: "Claude Julien",
                    goals: "2",
                    shots: "8",
                    tackles: "28",
                    pim: "6",
                    powerplayopportunities: "0",
                    powerplaygoals: "0",
                    faceoffwinpercentage: "61.8",
                    giveaways: "10",
                    takeaways: "7"
                  },
                  {
                    game_id: "2012030224",
                    team_id: "6",
                    hoa: "away",
                    result: "WIN",
                    settled_in: "OT",
                    head_coach: "Claude Julien",
                    goals: "3",
                    shots: "10",
                    tackles: "24",
                    pim: "8",
                    powerplayopportunities: "4",
                    powerplaygoals: "2",
                    faceoffwinpercentage: "53.7",
                    giveaways: "8",
                    takeaways: "6"
                  }]
                  ]

            expect(@season_statistics.group_by_team("20122013")).to eq(expected_array)
        end

        it 'has a most accurate team' do
            expect(@season_statistics.most_accurate_team("20122013")).to eq("FC Dallas")
            expect(@season_statistics.most_accurate_team("20142015")).to eq("DC United")
        end

        it 'has a least accurate team' do
            expect(@season_statistics.least_accurate_team("20122013")).to eq("Houston Dynamo")
            expect(@season_statistics.least_accurate_team("20142015")).to eq("New England Revolution")
        end

        it 'has most tackles' do
            expect(@season_statistics.most_tackles("20122013")).to eq("FC Dallas")
            expect(@season_statistics.most_tackles("20142015")).to eq("DC United")
        end

        it 'has fewest tackles' do
            expect(@season_statistics.fewest_tackles("20122013")).to eq("Houston Dynamo")
            expect(@season_statistics.fewest_tackles("20142015")).to eq("New England Revolution")
        end
    end
end