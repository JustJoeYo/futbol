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
    it '#find_teams' do #katya helper method one
      expect(@team_statistics.find_teams('14').first).to be_a(GameTeam)
      expect(@team_statistics.find_teams('14').first.game_id).to eq('2014030413')
      expect(@team_statistics.find_teams('14').first.team_id).to eq('14')
      expect(@team_statistics.find_teams('14').first.giveaways).to eq('10')

      expect(@team_statistics.find_teams('14')[1]).to be_a(GameTeam)
      expect(@team_statistics.find_teams('14')[1].game_id).to eq("2014030414")
      expect(@team_statistics.find_teams('14')[1].head_coach).to eq("Jon Cooper")
      expect(@team_statistics.find_teams('14')[1].takeaways).to eq("7")
    end

    it '#most_goals_scored' do #katya
      expect(@team_statistics.most_goals_scored('3')).to eq(2)
      expect(@team_statistics.most_goals_scored('14')).to eq(3)
      expect(@team_statistics.most_goals_scored('5')).to eq(3)
    end

    it '#fewest_goals_scored' do #katya
      expect(@team_statistics.fewest_goals_scored('3')).to eq(1)
      expect(@team_statistics.fewest_goals_scored('14')).to eq(1)
      expect(@team_statistics.fewest_goals_scored('5')).to eq(2)
    end

    it "#find_games" do #katya helper method two
      expect(@team_statistics.find_games('3').first).to be_a(GameTeam)
      expect(@team_statistics.find_games('3').first.game_id).to eq("2012030221")
      expect(@team_statistics.find_games('3').first.team_id).to eq("3")

      expect(@team_statistics.find_games('3')[1]).to be_a(GameTeam)
      expect(@team_statistics.find_games('3')[1].game_id).to eq("2012030221")
      expect(@team_statistics.find_games('3')[1].team_id).to eq("6")
      expect(@team_statistics.find_games('3')[1].result).to eq("WIN")

      expect(@team_statistics.find_games('3')[7]).to be_a(GameTeam)
      expect(@team_statistics.find_games('3')[7].team_id).to eq('5')
      expect(@team_statistics.find_games('3')[7].tackles).to eq('35')
    end

    #helper method three
    xit "#goup_teams" do #katya
      
    end

    #helper method four
    it "#goup_teams" do #katya
     
    end

    it '#favorite_opponent' do #katya
      expect(@team_statistics.favorite_opponent('3')).to eq("Sporting Kansas City")  
    end

    it '#rival' do
      expect(@team_statistics.rival('3')).to eq("FC Dallas") 
    end

    xit '#biggest_team_blowout' do
        
    end

    xit '#worst_loss' do
        
    end

    it '#head_to_head' do #katya
       expect(@team_statistics.head_to_head('3')).to eq({"Sporting Kansas City" => 50.0, "FC Dallas" => 100.0}) 
       expect(@team_statistics.head_to_head('6')).to eq({"Houston Dynamo"=>0.0})
       expect(@team_statistics.head_to_head('16')).to eq({"DC United"=>100.0})
    end

    xit '#seasonal_summary' do
        
    end
  end

  describe 'class methods' do
    
  end
end