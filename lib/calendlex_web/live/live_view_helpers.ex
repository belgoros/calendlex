defmodule CalendlexWeb.LiveViewHelpers do
  @moduledoc false

  def class_list(items) do
    items
    |> Enum.reject(&(elem(&1, 1) == false))
    |> Enum.map_join(" ", &elem(&1, 0))
  end
end
