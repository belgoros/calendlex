defmodule CalendlexWeb.InitAssigns do
  @moduledoc """
  Ensures common `assigns` are applied to all LiveViews attaching this hook.
  """
  use CalendlexWeb, :live_view

  def on_mount(:default, _params, _session, socket) do
    owner = Application.get_env(:calendlex, :owner)
    time_zone = get_connect_params(socket)["timezone"] || owner.time_zone

    socket =
      socket
      |> assign(:owner, owner)
      |> assign(:time_zone, time_zone)

    {:cont, socket}
  end
end
