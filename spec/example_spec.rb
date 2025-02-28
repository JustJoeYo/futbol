require 'spec_helper'  # Requires the spec_helper file for configuration and setup

# run `rspec` in the terminal to run the tests
# run `rspec spec/example_spec.rb` in the terminal to run only the tests in this file
# run 'open coverage/index.html' in the terminal to view the test coverage report

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Example do
  # Runs before each test to set up the necessary objects
  before(:each) do
    @example = Example.new("test")  # Creates a new Example object
  end

  # Describes the initialization behavior of the Example class
  describe 'initialization' do
    # Tests the initialization of a Example object
    it '#initialize' do
      expect(@example).to be_an_instance_of(Example)  # Expects the example to be an instance of the Example class
    end

    # Tests the attributes of a Example object
    it '#attributes' do
      expect(@example.name).to eq("test")  # Expects the Example's name to be "test"
    end
  end

  # Placeholder for instance methods tests
  describe 'instance methods' do
    
  end

  # Placeholder for class methods tests
  describe 'class methods' do
    
  end
end