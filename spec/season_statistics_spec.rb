require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe SeasonStatistics do
  before(:each) do 
    @game_teams_path = CSV.read('./data/game_team_fixture.csv', headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }
    @games_path = CSV.read('./data/games_fixture.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @team_path = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @season_statistics = SeasonStatistics.new(@game_teams_path, @games_path, @team_path)
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
    describe "#games_in_season" do
      it 'has an array of games' do
        expected_result_array = @game_teams_path.select { |game_team| ["2015030141", "2015030142"].include?(game_team.game_id) }
        expect(@season_statistics.games_in_season("20152016")).to eq(expected_result_array)
      end
    end

    describe "#group_by_coach" do
      it 'can group the data set by coach' do
        expected_result_array = @game_teams_path.select { |game_team| ["2012030221", "2012030222", "2012030223", "2012030224"].include?(game_team.game_id) }.group_by(&:head_coach).values
        expect(@season_statistics.group_by_coach("20122013")).to eq(expected_result_array)
      end
    end

    describe "#group_by_team" do
      it 'can group by team id' do
        expected_result_array = @game_teams_path.select { |game_team| ["2012030221", "2012030222", "2012030223", "2012030224"].include?(game_team.game_id) }.group_by(&:team_id).values
        expect(@season_statistics.group_by_team("20122013")).to eq(expected_result_array)
      end
    end

    describe "#coach_stats" do
      it 'can create a hash of coach stats' do
        expected_hash = {"John Tortorella" => {wins: 0, games: 3}, "Claude Julien" => {wins: 4, games: 4}}
        expect(@season_statistics.calculate_coach_stats("20122013")).to eq(expected_hash)
      end
    end

    describe "#team_stats" do
      it 'can create a hash of team stats' do
        expect(@season_statistics.calculate_team_stats("20122013", :tackles)).to eq({"3" => {tackles: 114}, "6" => {tackles: 139}})
        expect(@season_statistics.calculate_team_stats("20152016", :shots, :goals)).to eq({"3" => {shots: 16, goals: 4}, "5" => {shots: 14, goals: 5}})
      end
    end

    describe "#find_team_name" do
      it 'can return a team name when given a team id' do
        expect(@season_statistics.find_team_name(16)).to eq("New England Revolution")
        expect(@season_statistics.find_team_name("2")).to eq("Seattle Sounders FC")
      end
    end

    describe "#winningest_coach" do
      it 'has a coach with best win percentage' do
        expect(@season_statistics.winningest_coach("20122013")).to eq("Claude Julien")
        expect(@season_statistics.winningest_coach("20142015")).to eq("Jon Cooper")
        expect(@season_statistics.winningest_coach("20152016")).to eq("Mike Sullivan")
      end
    end

    describe "#worst_coach" do 
      it 'has a coach with worst win percentage' do
        expect(@season_statistics.worst_coach("20122013")).to eq("John Tortorella")
        expect(@season_statistics.worst_coach("20142015")).to eq("Joel Quenneville")
        expect(@season_statistics.worst_coach("20152016")).to eq("Alain Vigneault")
      end
    end

    describe "#most_accurate_team" do
      it 'has a team with best ratio of shots to goals' do
        expect(@season_statistics.most_accurate_team("20122013")).to eq("FC Dallas")
        expect(@season_statistics.most_accurate_team("20142015")).to eq("DC United")
        expect(@season_statistics.most_accurate_team("20152016")).to eq("Sporting Kansas City")
      end
    end

    describe "#least_accurate_team" do
      it 'has a team with worst ratio of shots to goals' do
        expect(@season_statistics.least_accurate_team("20122013")).to eq("Houston Dynamo")
        expect(@season_statistics.least_accurate_team("20142015")).to eq("New England Revolution")
        expect(@season_statistics.least_accurate_team("20152016")).to eq("Houston Dynamo")
      end
    end

    describe "#most_tackles" do
      it 'has a team with the most tackles' do
        expect(@season_statistics.most_tackles("20122013")).to eq("FC Dallas")
        expect(@season_statistics.most_tackles("20142015")).to eq("DC United")
        expect(@season_statistics.most_tackles("20152016")).to eq("Houston Dynamo")
      end
    end

    describe "#least_tackles" do
      it 'has team with the fewest tackles' do
        expect(@season_statistics.fewest_tackles("20122013")).to eq("Houston Dynamo")
        expect(@season_statistics.fewest_tackles("20142015")).to eq("New England Revolution")
        expect(@season_statistics.fewest_tackles("20152016")).to eq("Sporting Kansas City")
      end
    end
  end
end