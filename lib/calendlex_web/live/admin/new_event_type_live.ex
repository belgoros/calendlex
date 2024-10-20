defmodule CalendlexWeb.Admin.NewEventTypeLive do
  @moduledoc false
  use CalendlexWeb, :admin_live_view

  alias Calendlex.EventType

  @impl true
  def mount(_params, _session, socket) do
    event_type = %EventType{}

    socket =
      socket
      |> assign(section: "event_types")
      |> assign(page_title: "New event type")
      |> assign(event_type: event_type)
      |> assign(changeset: EventType.changeset(event_type, %{}))

    {:ok, socket}
  end

  @impl true
  def handle_info({:submit, params}, socket) do
    params
    |> Calendlex.insert_event_type()
    |> case do
      {:ok, event_type} ->
        socket = put_flash(socket, :info, "Saved")

        {:noreply,
         push_patch(socket,
           to: ~p"/admin/event_types/#{event_type.id}"
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
