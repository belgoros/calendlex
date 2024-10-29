defmodule CalendlexWeb.Admin.Components.EventType do
  @moduledoc false

  use CalendlexWeb, :live_component

  alias CalendlexWeb.Admin.Components.Dropdown

  def mount(socket) do
    {:ok, socket}
  end

  def handle_params(_, _, socket) do
    event_types = Calendlex.available_event_types()

    socket =
      socket
      |> assign(event_types: event_types)
      |> assign(event_types_count: length(event_types))
      |> assign(section: "event_types")
      |> assign(page_title: "Event types")
      |> assign(delete_event_type: nil)

    {:noreply, socket}
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

  def handle_event("delete_me", _params, socket) do
    event_type = socket.assigns.event_type

    send(self(), {:confirm_delete, event_type})

    {:noreply, socket}
  end
end
