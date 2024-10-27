defmodule CalendlexWeb.Admin.EditEventTypeLive do
  use CalendlexWeb, :admin_live_view

  alias Calendlex.EventType
  alias CalendlexWeb.Admin.Components.EventTypeForm

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    case Calendlex.get_event_type_by_id(id) do
      {:ok, %EventType{name: name} = event_type} ->
        changeset = EventType.changeset(event_type, %{})

        socket =
          socket
          |> assign(section: "event_types")
          |> assign(page_title: "Edit #{name}")
          |> assign(event_type: event_type)
          |> assign(form: to_form(changeset))

        {:ok, socket}

      _ ->
        {:ok, socket, layout: {CalendlexWeb.LayoutView, "not_found.html"}}
    end
  end

  @impl true
  def handle_info({:submit, params}, %{assigns: %{event_type: event_type}} = socket) do
    changeset = EventType.changeset(event_type, %{})

    event_type
    |> Calendlex.update_event_type(params)
    |> case do
      {:ok, event_type} ->
        socket =
          socket
          |> put_flash(:info, "Saved")
          |> assign(event_type: event_type)
          |> assign(form: to_form(changeset))
          |> redirect(to: ~p"/#{event_type.slug}")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
