require_relative 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
  end

RSpec.describe GameTeam do
    before(:each) do