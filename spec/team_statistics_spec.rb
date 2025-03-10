require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe TeamStatistics do
  before(:each) do
    @teams = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @games = CSV.read('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = CSV.read('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }

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
    describe 'helper methods' do
      it '#season_win_percentages' do
        expected_values = {
          "20122013" => 0.36,
          "20132014" => 0.29,
          "20142015" => 0.39,
          "20152016" => 0.35,
          "20162017" => 0.41,
          "20172018" => 0.28,
        }
        expect(@team_statistics.season_win_percentages("9")).to eq(expected_values)
      end
  
      it '#season' do
        game_team = @game_teams.find { |gt| gt.game_id == "2012030222" }
        expect(@team_statistics.send(:season, game_team)).to eq("20122013")
      end
    end

    it '#team_info' do
      expected_values = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }
      expect(@team_statistics.team_info('18')).to eq(expected_values)
    end

    it '#best_season' do
      expect(@team_statistics.best_season("1")).to eq("20152016")
    end

    it '#worst_season' do
      expect(@team_statistics.worst_season("1")).to eq("20162017")
    end

    it '#average_win_percentage' do
      expect(@team_statistics.average_win_percentage("9")).to eq(0.35)
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