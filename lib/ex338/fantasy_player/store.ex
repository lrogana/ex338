defmodule Ex338.FantasyPlayer.Store do
  @moduledoc false

  use Ex338Web, :model

  alias Ex338.{Championship, FantasyTeam, FantasyPlayer, Repo}

  def all_plyrs_for_lg(league) do
    league
    |> FantasyTeam.right_join_players_by_league
    |> Repo.all
    |> Enum.group_by(fn %{league_name: league_name} -> league_name end)
  end

  def available_players(fantasy_league_id) do
    fantasy_league_id
    |> FantasyPlayer.available_players
    |> Repo.all
  end

  def get_all_players do
    FantasyPlayer
    |> FantasyPlayer.alphabetical_by_league
    |> Repo.all
  end

  def get_avail_players_for_champ(league_id, sport_id) do
    FantasyPlayer
    |> FantasyPlayer.avail_players_for_champ(league_id, sport_id)
    |> Repo.all
  end

  def get_next_championship(query, player_id, league_id) do
    query = from p in query,
      inner_join: s in assoc(p, :sports_league),
      inner_join: c in subquery(
        Championship.future_championships(Championship, league_id)),
       on: c.sports_league_id == s.id,
      where: p.id == ^player_id,
      limit: 1,
      select: c

    Repo.one(query)
  end

  def player_with_sport!(query, id) do
    query = from f in query,
      preload: [:sports_league],
      where: f.id == ^id

    Repo.one(query)
  end
end
