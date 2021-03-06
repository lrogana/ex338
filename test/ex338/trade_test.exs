defmodule Ex338.TradeTest do
  use Ex338.DataCase, async: true

  alias Ex338.Trade

  @valid_attrs %{status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Trade.changeset(%Trade{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Trade.changeset(%Trade{}, @invalid_attrs)
    refute changeset.valid?
  end
end
