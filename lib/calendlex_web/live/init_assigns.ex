defmodule CalendlexWeb.InitAssigns do
  @moduledoc """
  Ensures common `assigns` are applied to all LiveViews attaching this hook.
  """
  # import Phoenix.LiveView
  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    owner = Application.get_env(:calendlex, :owner)
    socket = assign(socket, :owner, owner)

    {:cont, socket}
  end
end
