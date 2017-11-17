defmodule Ex338Web.TradeController do
  use Ex338Web, :controller

  alias Ex338.{FantasyLeague, Trade, TradeLineItem, FantasyTeam}
  alias Ex338Web.{Authorization}

  import Canary.Plugs

  plug :load_and_authorize_resource, model: FantasyTeam, only: [:create, :new],
    preload: [:owners, :fantasy_league], persisted: true,
    id_name: "fantasy_team_id",
    unauthorized_handler: {Authorization, :handle_unauthorized}

  def index(conn, %{"fantasy_league_id" => league_id}) do
    league = FantasyLeague.Store.get(league_id)

    render(conn, "index.html",
     fantasy_league: league,
     trades: Trade.Store.all_for_league(league.id)
    )
  end

  def new(conn, %{"fantasy_team_id" => _id}) do
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
    team = %{fantasy_league_id: league_id} = conn.assigns.fantasy_team
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
