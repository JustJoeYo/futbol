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

    xit '#most_goals_scored' do
        
    end

    xit '#fewest_goals_scored' do
        
    end

    xit '#favorite_opponent' do
        
    end

    describe '#rival' do
      xit 'returns the opponent with the highest win percentage against the given team' do
        expect(@team_statistics.rival('6')).to eq("Sporting Kansas City")
        expect(@team_statistics.rival('3')).to eq("FC Dallas")
      end

      xit 'returns 'No Rival Found" if the team has no opponents" do
        expect(@team_statistics.rival('3')).to eq("No Rival Found")
      end
      
    end

    describe '#biggest_team_blowout' do
      it 'returns the largest margin of victory for a given team' do
        expect(@team_statistics.biggest_team_blowout('6')).to eq(3) #FC Dallas beat Sporting KC 4-1
        expect(@team_statistics.biggest_team_blowout('3')).to eq(1) #Houston Dynamo biggest win was 2-1
      end

      it 'returns 0 if the team has no wins' do
        expect(@team_statistics.biggest_team_blowout('9999')).to eq(0) #Fake
      end
    end

    describe '#worst_loss' do
      it 'returns the biggest loss for a given team' do
        expect(@team_statistics.worst_loss('6')).to eq(1) #FC Dallas lost 1-3 to Houston
        expect(@team_statistics.worst_loss('3')).to eq(2) #Houston Dynamo lost 1-3 to FC
      end

      it 'returns 0 if the team has no losses' do
        expect(@team_statistics.worst_loss('9999')).to eq(0) #Fake
      end
    end

    xit '#head_to_head' do
        
    end

    xit '#seasonal_summary' do
      it 'returns a hash with season statistics for a given team' do
        expected_summary = {
          "20122013" => {
            "regular_season" => {
              win_percentage: 0.5,
              total_goals_scored: 9,
              total_goals_against: 6,
              average_goals_scored: 3.0,
              average_goals_against: 2.0
            },
            "postseason" => {
              win_percentage: 0.67,
              total_goals_scored: 10,
              total_goals_against: 7,
              average_goals_scored: 2.5,
              average_goals_against: 2.33
            }
          }
        }

        expect(@team_statistics.seasonal_summary('6')).to eq(expected_summary)
      end
        
    end
  end

  describe 'class methods' do
    
  end
end