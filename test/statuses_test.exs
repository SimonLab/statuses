defmodule StatusesTest do
  use ExUnit.Case
  doctest Statuses

  test "parse_json returns a list of maps containing statuses" do
    list = Statuses.parse_json()
    # assert Enum.count(list) == Utils.count()

    # sample status we know is in the list
    sample = %{
      id: "1",
      text: "verified"
    }

    # find the sample quote in the List of Maps:
    [found] =
      Enum.map(list, fn q ->
        if q.text == sample.text do
          q
        end
      end)
      # filter out any nil values
      |> Enum.filter(&(!is_nil(&1)))

    # sample status was found in the list
    assert sample.id == found.id
  end
end
