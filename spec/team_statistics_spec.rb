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

    end

    describe '#biggest_team_blowout' do
      it 'returns the largest margin of victory for a given team' do
        expect(@team_statistics.biggest_team_blowout('6')).to eq(1) #FC Dallas biggest win was 3-2 with fixture
        expect(@team_statistics.biggest_team_blowout('3')).to eq(0) #Houston Dynamo has no wins in the fixture
      end

      it 'returns 0 if the team has no wins' do
        expect(@team_statistics.biggest_team_blowout('9999')).to eq(0) #Fake
      end
    end

    describe '#worst_loss' do
      it 'returns the biggest loss for a given team' do
        expect(@team_statistics.worst_loss('6')).to eq(0) #FC Dallas has no losses with the fixture
        expect(@team_statistics.worst_loss('3')).to eq(1) #Houston Dynamo biggest loss was 2-3
      end

      it 'returns 0 if the team has no losses' do
        expect(@team_statistics.worst_loss('9999')).to eq(0) #Fake
      end
    end

    xit '#head_to_head' do
        
    end

    describe '#seasonal_summary' do
      it 'returns a hash with season statistics for a given team' do
        expected_summary = {
          "20122013" => {
            "regular_season" => { #No regular season games in fixture
              win_percentage: 0.0,
              total_goals_scored: 0,
              total_goals_against: 0,
              average_goals_scored: 0,
              average_goals_against: 0
            },
            "postseason" => {
              win_percentage: 1.0,
              total_goals_scored: 11,
              total_goals_against: 7,
              average_goals_scored: 2.75,
              average_goals_against: 1.75
            }
          }
        }

        expect(@team_statistics.seasonal_summary('6')).to eq(expected_summary)
      end
    end
  end

  describe 'helper methods' do
    describe '#games_involving_team' do
      it 'returns all game_team records for a given team' do
        expect(@team_statistics.games_involving_team('6').size).to eq(4)
        expect(@team_statistics.games_involving_team('3').size).to eq(5)
        expect(@team_statistics.games_involving_team('9999')).to eq([])
      end
    end

    describe '#find_season_by_game_id' do
      it 'returns the correct season for a given game_id' do
        expect(@team_statistics.find_season_by_game_id('2012030221')).to eq('20122013')
        expect(@team_statistics.find_season_by_game_id('2015030141')).to eq('20152016')
      end
    end

    describe '#calculate_season_stats' do
      it 'returns correct stats for a season given game_team records' do
        team_id = '6' #FC Dallas

        games = @team_statistics.games_involving_team(team_id)

        expected_stats = {
          win_percentage: 1.0,
          total_goals_scored: 11,
          total_goals_against: 7,
          average_goals_scored: 2.75,
          average_goals_against: 1.75
        }

        expect(@team_statistics.calculate_season_stats(games, team_id)).to eq(expected_stats)
      end

      it 'returns default stats if no games are found' do
        expected_default_stats = {
          win_percentage: 0.0,
          total_goals_scored: 0,
          total_goals_against: 0,
          average_goals_scored: 0.0,
          average_goals_against: 0.0
        }

        expect(@team_statistics.calculate_season_stats([], '9999')).to eq(expected_default_stats)
      end
    end

    describe '#find_game_type' do
      it 'returns the correct type of game (Regular Season or Postseason)' do
        expect(@team_statistics.find_game_type('2012030221')).to eq('Postseason')
        expect(@team_statistics.find_game_type('2015030141')).to eq('Postseason')
      end
    end

    describe '#find_opponent_score' do
      it 'returns the number of goals scored by the opponent' do
        team_id = '6'
        game = @team_statistics.games_involving_team(team_id).first

        expect(@team_statistics.find_opponent_score(game, team_id)).to eq(2)
      end
    end

    describe '#games_won_by_team' do
      it 'returns all games that a given team has won' do
        expect(@team_statistics.games_won_by_team('6').size).to eq(4)
        expect(@team_statistics.games_won_by_team('3').size).to eq(0)
      end
    end

    describe '#games_lost_by_team' do
      it 'returns all games that a give team has lost' do
        expect(@team_statistics.games_lost_by_team('6').size).to eq(0)
        expect(@team_statistics.games_lost_by_team('3').size).to eq(4)
      end
    end

    describe '#goal_difference' do
      it 'calculates the correct goal differential for a game' do
        team_id = '6'
        game = @team_statistics.games_involving_team(team_id).first

        expect(@team_statistics.goal_difference(game, team_id)).to eq(1)
      end

      it 'returns absolute value of goal difference for losses' do
        team_id = '3'
        game = @team_statistics.games_involving_team(team_id).first

        expect(@team_statistics.goal_difference(game, team_id)).to eq(1)
      end
    end
  end

  describe 'class methods' do
    
  end
end