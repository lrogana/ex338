defmodule Ex338Web.TradeController do
  use Ex338Web, :controller

  alias Ex338.{FantasyLeague, Trade, TradeLineItem, FantasyTeam}

  def index(conn, %{"fantasy_league_id" => league_id}) do
    league = FantasyLeague.Store.get(league_id)

    render(conn, "index.html",
     fantasy_league: league,
     trades: Trade.Store.all_for_league(league.id)
    )
  end
  def new(conn, %{"fantasy_team_id" => id}) do
    trade =
      %Trade{trade_line_items:
       [
         %TradeLineItem{},
         %TradeLineItem{},
         %TradeLineItem{},
         %TradeLineItem{},
       ]
     }
    changeset = Trade.new_changeset(trade)
    team = %{fantasy_league_id: league_id} = FantasyTeam.Store.find(id)
    league_teams = FantasyTeam.Store.list_teams_for_league(league_id)
    league_players = FantasyTeam.Store.owned_players_for_league(league_id)

    render(conn, "new.html",
      changeset: changeset,
      fantasy_team: team,
      league_teams: league_teams,
      league_players: league_players,
    )
  end
end
