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
    xit '#find_games' do #katya helper method one
      expect(@team_statistics.find_games('3')).to eq()
    end

    it '#most_goals_scored' do #katya
      expect(@team_statistics.most_goals_scored('3')).to eq(2)
    end

    it '#fewest_goals_scored' do #katya
      expect(@team_statistics.fewest_goals_scored('3')).to eq(1)
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