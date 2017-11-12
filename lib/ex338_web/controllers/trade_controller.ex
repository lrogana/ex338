defmodule Ex338Web.TradeController do
  use Ex338Web, :controller

  alias Ex338.{FantasyLeague, Trade, FantasyTeam}

  def index(conn, %{"fantasy_league_id" => league_id}) do
    league = FantasyLeague.Store.get(league_id)

    render(conn, "index.html",
     fantasy_league: league,
     trades: Trade.Store.all_for_league(league.id)
    )
  end
  def new(conn, %{"fantasy_team_id" => id}) do
    changeset = Trade.changeset(%Trade{})
    team = FantasyTeam.Store.find(id)
    render(conn, "new.html",
      changeset: changeset,
      fantasy_team: team
    )
  end
end
