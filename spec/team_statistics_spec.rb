require 'spec_helper'
require 'pry'


RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe TeamStatistics do
  before(:each) do
    @teams = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @games = CSV.read('./data/games_fixture.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = CSV.read('./data/game_team_fixture.csv', headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }

    @team_statistics = TeamStatistics.new(@teams, @games, @game_teams)
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@team_statistics).to be_an_instance_of(TeamStatistics)
    end

    it '#attributes' do
      expect(@team_statistics.instance_variable_get(:@teams)).not_to be_empty
    end
  end

  describe 'instance methods' do
    it '#team_info' do
      expected = {
        team_id: '1',
        franchise_id: '23',
        team_name: 'Atlanta United',
        abbreviation: 'ATL',
        link: '/api/v1/teams/1'
      }
      expect(@team_statistics.team_info('1')).to eq(expected)
    end

    xit '#best_season' do # make it instead of xit as we add the functionality
        
    end

    xit '#worst_season' do
        
    end

    xit '#average_win_percentage' do
        
    end
    it '#find_games' do #katya helper method one
      expected_games = [
        GameTeam.new({
          game_id: "2014030413",
          team_id: "14",
          hoa: "away",
          result: "WIN",
          settled_in: "REG",
          head_coach: "Jon Cooper",
          goals: '3',
          shots: '8',
          tackles: '46',
          pim: '6',
          powerplayopportunities: '2',
          powerplaygoals: '0',
          faceoffwinpercentage: '41.8',
          giveaways: '10',
          takeaways: '7'
        }),
        GameTeam.new({
          game_id: "2014030414",
          team_id: "14",
          hoa: "away",
          result: "LOSS",
          settled_in: "REG",
          head_coach: "Jon Cooper",
          goals: '1',
          shots: '6',
          tackles: '46',
          pim: '6',
          powerplayopportunities: '4',
          powerplaygoals: '0',
          faceoffwinpercentage: '34.5',
          giveaways: '5',
          takeaways: '7'
        })
      ]
      allow(@team_statistics).to receive(:find_games).with('14').and_return(expected_games)
      expect(@team_statistics.find_games('14')).to eq(expected_games)
    end

    it '#most_goals_scored' do #katya
      expect(@team_statistics.most_goals_scored('3')).to eq(2)
    end

    it '#fewest_goals_scored' do #katya
      expect(@team_statistics.fewest_goals_scored('3')).to eq(1)
    end

    xit '#opponent_games' do
      expect(@team_statistics.opponent_games('16')).to eq()
    end

    it '#opponent_stats' do
      expect(@team_statistics.opponent_stats('16')).to eq()
    end

    xit '#favorite_opponent' do #katya
        
    end

    xit '#rival' do
        
    end

    xit '#biggest_team_blowout' do
        
    end

    xit '#worst_loss' do
        
    end

    xit '#head_to_head' do #katya
        
    end

    xit '#seasonal_summary' do
        
    end
  end

  describe 'class methods' do
    
  end
end