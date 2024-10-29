defmodule CalendlexWeb.Admin.Components.EventType do
  @moduledoc false

  use CalendlexWeb, :live_component

  alias CalendlexWeb.Admin.Components.Dropdown

  def mount(socket) do
    {:ok, socket}
  end

  def handle_event("clone_me", _params, socket) do
    event_type = socket.assigns.event_type

    case Calendlex.clone_event_type(event_type) do
      {:ok, new_event_type} ->
        socket =
          socket
          |> redirect(to: ~p"/admin/event_types/#{new_event_type.id}")

        {:noreply, socket}

      {:error, _} ->
        send(self(), :clone_error)
        {:noreply, socket}
    end
  end
end
