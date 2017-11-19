defmodule Ex338.TradeTest do
  use Ex338.DataCase, async: true

  alias Ex338.Trade

  @valid_attrs %{}

  test "changeset requires no attributes and provides default status" do
    changeset = Trade.changeset(%Trade{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.data.status == "Pending"
  end
end
