require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @StatTracker = StatTracker.from_csv(@locations)
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
    end

    it '#attributes' do
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
      expect(@StatTracker.game_statistics).to be_an_instance_of(GameStatistics) # sanity checking for the instance of the class's
      expect(@StatTracker.league_statistics).to be_an_instance_of(LeagueStatistics)
      expect(@StatTracker.season_statistics).to be_an_instance_of(SeasonStatistics)
      expect(@StatTracker.team_statistics).to be_an_instance_of(TeamStatistics)
    end
  end

  # Placeholder for instance methods tests
  describe 'instance methods' do

    describe 'Game Statistics' do
      it '#highest_total_score' do
        expect(@StatTracker.highest_total_score).to eq 11
      end

      it '#lowest_total_score' do
        expect(@StatTracker.lowest_total_score).to eq 0
      end

      it 'returns the percentage of home wins' do
        expect(@StatTracker.percentage_home_wins).to eq 0.44
      end

      it '#percentage_visitor_wins' do
        expect(@StatTracker.percentage_visitor_wins).to eq 0.36
      end

      it '#percentage_ties' do
        expect(@StatTracker.percentage_ties).to eq 0.20
      end

      it '#count_of_games_by_season' do
        expected = {
          "20122013" => 806,
          "20132014" => 1323,
          "20142015" => 1319,
          "20152016" => 1321,
          "20162017" => 1317,
          "20172018" => 1355
        }
        expect(@StatTracker.count_of_games_by_season).to eq expected
      end

      it '#average_goals_per_game' do
        expect(@StatTracker.average_goals_per_game).to eq 4.22
      end

      it '#average_goals_by_season' do
        expected = {
          "20122013" => 4.12,
          "20132014" => 4.19,
          "20142015" => 4.14,
          "20152016" => 4.16,
          "20162017" => 4.23,
          "20172018" => 4.44
        }
        expect(@StatTracker.average_goals_by_season).to eq expected
      end
    end
    
    describe 'League Statistics' do
      it '#count_of_teams' do
        expect(@StatTracker.count_of_teams).to eq 32
      end

      it '#best_offense' do
        expect(@StatTracker.best_offense).to eq 'Reign FC'
      end

      it '#worst_offense' do
        expect(@StatTracker.worst_offense).to eq 'Utah Royals FC'
      end

      it '#highest_scoring_visitor' do
        expect(@StatTracker.highest_scoring_visitor).to eq 'FC Dallas'
      end

      it '#highest_scoring_home_team' do
        expect(@StatTracker.highest_scoring_home_team).to eq 'Reign FC'
      end

      it '#lowest_scoring_visitor' do
        expect(@StatTracker.lowest_scoring_visitor).to eq 'San Jose Earthquakes'
      end

      it '#lowest_scoring_home_team' do
        expect(@StatTracker.lowest_scoring_home_team).to eq 'Utah Royals FC'
      end
    end

    describe 'Season Statistics' do
      it '#winningest_coach' do
        expect(@StatTracker.winningest_coach("20132014")).to eq "Claude Julien"
      end

      it '#worst_coach' do
          expect(@StatTracker.worst_coach("20132014")).to eq "Peter Laviolette"
      end

      it '#most_accurate_team' do
          expect(@StatTracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      end

      it '#least_accurate_team' do
          expect(@StatTracker.least_accurate_team("20132014")).to eq "New York City FC"
      end

      it '#most_tackles' do
          expect(@StatTracker.most_tackles("20132014")).to eq "FC Cincinnati"
      end

      it '#fewest_tackles' do
          expect(@StatTracker.fewest_tackles("20132014")).to eq "Atlanta United"
      end
    end

    describe 'Season Statistics' do
      it '#team_info' do
        expect(@StatTracker.team_info("")).to eq ""
      end
      it '#best_season' do
        expect(@StatTracker.best_season("")).to eq ""
      end
      it '#worst_season' do
        expect(@StatTracker.worst_season("")).to eq ""
      end
      it '#average_win_percentage' do
        expect(@StatTracker.average_win_percentage("")).to eq ""
      end
      it '#most_goals_scored' do
        expect(@StatTracker.most_goals_scored("")).to eq ""
      end
      it '#fewest_goals_scored' do
        expect(@StatTracker.fewest_goals_scored("")).to eq ""
      end
      it '#favorite_opponent' do
        expect(@StatTracker.favorite_opponent("")).to eq ""
      end
      it '#rival' do
        expect(@StatTracker.rival("")).to eq ""
      end
      it '#head_to_head' do
        expect(@StatTracker.head_to_head("")).to eq ""
      end
      it '#biggest_team_blowout' do
        expect(@StatTracker.biggest_team_blowout("")).to eq ""
      end
      it '#worst_loss' do
        expect(@StatTracker.worst_loss("")).to eq ""
      end
      it '#seasonal_summary' do
        expect(@StatTracker.seasonal_summary("")).to eq ""
      end
    end
  end

  # class methods only (keyword 'self')
  describe 'class methods' do
    it '::from_csv' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
    end
  end
end