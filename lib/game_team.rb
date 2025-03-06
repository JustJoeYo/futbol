  class GameTeam
    attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways

    def initialize(game_team_data)
      @game_id = game_team_data[:game_id]
      @team_id = game_team_data[:team_id]
      @hoa = game_team_data[:hoa]
      @result = game_team_data[:result]
      @settled_in = game_team_data[:settled_in]
      @head_coach = game_team_data[:head_coach]
      @goals = game_team_data[:goals]
      @shots = game_team_data[:shots]
      @tackles = game_team_data[:tackles]
      @pim = game_team_data[:pim]
      @power_play_opportunities = game_team_data[:powerplayopportunities]
      @power_play_goals = game_team_data[:powerplaygoals]
      @face_off_win_percentage = game_team_data[:faceoffwinpercentage]
      @giveaways = game_team_data[:giveaways]
      @takeaways = game_team_data[:takeaways]
    end
  end