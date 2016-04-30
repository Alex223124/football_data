module Stats
  class PlayerPassing
    include Interactor

    def scope
      @scope ||= Pass.all
    end

    def before
      if context[:scope]
        fail!("Invalid base scope for calculation") if !context[:scope].is_a?(scope.class)
        @scope = context[:scope]
      end
    end

    def calculation
      scope.
        select("_players.first_name || ' ' || _players.last_name AS passer").
        select("_teams.abbreviation AS team").
        select("_games.week AS week").
        select("_games.season AS week").
        select("_possessions.quarter AS quarter").
        select("(events.data->'pass_attempt')::integer AS pass_attempts").
        select("(events.data->'pass_completion')::integer AS pass_completions").
        select("(events.data->'pass_drop')::integer AS pass_drops").
        select("(events.data->'pass_yards')::integer AS pass_yards").
        select("(events.data->'pass_touchdown')::integer AS pass_touchdowns").
        select("(events.data->'pass_interception')::integer AS pass_interceptions").
        joins("INNER JOIN players AS _players ON events.primary_player_id = _players.id").
        joins("INNER JOIN teams AS _teams ON events.offense_team_id = _teams.id").
        joins("INNER JOIN games AS _games ON events.game_id = _games.id").
        joins("INNER JOIN possessions AS _possessions ON events.possession_id = _possessions.id").
        to_sql
    end

    def perform
      results = ActiveRecord::Base.connection.select_all(calculation)
      context[:results] = parse_results(results) 
      context[:headers] = parse_headers(results)
    end

    def after

    end

    private

    def parse_results(results)
      results.map do |result|
        result.values
      end
    end

    def parse_headers(results)
      results.columns
    end
  end
end
