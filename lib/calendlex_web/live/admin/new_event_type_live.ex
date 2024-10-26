defmodule CalendlexWeb.Admin.NewEventTypeLive do
  @moduledoc false
  alias CalendlexWeb.Admin.Components.EventType
  use CalendlexWeb, :admin_live_view

  alias CalendlexWeb.Admin.Components.EventTypeForm
  alias Calendlex.EventType

  @impl true
  def mount(_params, _session, socket) do
    changeset = EventType.changeset(%EventType{}, %{})

    socket =
      assign(socket,
        section: "event_types",
        page_title: "New event type",
        event_type: %EventType{},
        form: to_form(changeset)
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-4/5 p-6 mx-auto mb-2 bg-white border border-gray-200 rounded-md shadow-md">
      <.live_component
        id="new_event_type_form"
        module={EventTypeForm}
        event_type={@event_type}
        form={@form}
      />
    </div>
    """
  end

  @impl true
  def handle_info({:submit, params}, socket) do
    params
    |> Calendlex.insert_event_type()
    |> case do
      {:ok, event_type} ->
        {:noreply,
         socket
         |> put_flash(:info, "Time Event saved successfully")
         |> redirect(to: ~p"/#{event_type.slug}")}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
