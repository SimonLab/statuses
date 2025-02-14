defmodule Statuses do
  require Logger

  @moduledoc """
  Documentation for `Statuses`.
  """

  @doc """
  `parse_json/0` returns a list of maps containing statuses. e.g:

  ```elixir
  [
    %{
      id: "1",
      text: "verified",
      "desc": "A person verified by a 3rd party OAuth provider"
    },
    ...
  ]
  ```

  All statuses MUST have an `id` and `text` field.
  Ideally they should also have a `desc` (description),
  please help to expand/refine the description any status 
  that is not well defined but avoid changing the `text` or `id`.
  """
  def parse_json do
    {:ok, cwd} = File.cwd()

    Logger.info(cwd)
    Logger.info(Path.expand("../statuses.json"))
    # we need this cd to locate the file in /deps
    case cwd =~ "/statuses" do
      true ->
        read_decode()

      # coveralls-ignore-start
      # temporarily cd into deps/quotes dir and read quotes.json file:
      false ->
        Logger.info("change directory!!")
        File.cd!("deps/statuses")
        data = read_decode()
        # chnge back into the root directory
        File.cd!("../..")
        # return the decoded (parsed) JSON data
        data
        # coveralls-ignore-stop
    end
  end

  defp read_decode do
    File.read!("statuses.json")
    |> Jason.decode!()
    |> Enum.map(fn m -> Useful.atomize_map_keys(m) end)
  end
end
