require 'spec_helper'

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
      expect(@team_statistics.instance_variable_get(:@games)).not_to be_empty
      expect(@team_statistics.instance_variable_get(:@game_teams)).not_to be_empty
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

    it '#best_season' do
      expect(@team_statistics.best_season("1")).to eq("20122013")
    end

    it '#worst_season' do
      expect(@team_statistics.worst_season("1")).to eq("20122013")
    end

    it '#average_win_percentage' do
      expect(@team_statistics.average_win_percentage("9")).to eq(0.33)
    end

    xit '#most_goals_scored' do
        
    end

    xit '#fewest_goals_scored' do
        
    end

    xit '#favorite_opponent' do
        
    end

    xit '#rival' do
        
    end

    xit '#biggest_team_blowout' do
        
    end

    xit '#worst_loss' do
        
    end

    xit '#head_to_head' do
        
    end

    xit '#seasonal_summary' do
        
    end
  end
end