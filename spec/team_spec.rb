require_relative 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
  end

RSpec.describe Team do
    before(:each) do
        @team_data = {
            team_id: "1",
            franchiseId: "23",
            teamName: "Atlanta United",
            abbreviation: "ATL",
            Stadium: "Mercedes-Benz Stadium",
            link: "/api/v1/teams/1"
        }
        @team = Team.new(@team_data)
    end

    describe '#initialize' do
        it 'exists' do
            expect(@team).to be_a(Team)
        end

        it 'initializes with correct attributes' do
            expect(@team.team_id).to eq("1")
            expect(@team.franchiseId).to eq("23")
            expect(@team.teamName).to eq("Atlanta United")
            expect(@team.abbreviation).to eq("ATL")
            expect(@team.Stadium)
        end
    end