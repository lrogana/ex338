defmodule Ex338.FantasyLeague.Store do
  @moduledoc false

  alias Ex338.{FantasyLeague, Repo}

  def get(id) do
    Repo.get(FantasyLeague, id)
  end
end
