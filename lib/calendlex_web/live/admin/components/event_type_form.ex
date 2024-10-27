defmodule CalendlexWeb.Admin.Components.EventTypeForm do
  @moduledoc false
  use CalendlexWeb, :live_component

  alias Calendlex.EventType
  alias Ecto.Changeset

  @colors ~w(red yellow green blue indigo pink purple)

  # @impl true
  # def mount(socket) do
  #  changeset = EventType.change_event_type(%EventType{})
  #  {:ok, assign(socket, :form, to_form(changeset))}
  # end

  @impl true
  def update(
        %{
          event_type: %EventType{color: current_color, slug: slug} = event_type,
          form: form
        },
        socket
      ) do
    socket =
      socket
      |> assign(colors: @colors)
      |> assign(form: form)
      |> assign(event_type: event_type)
      |> assign(current_color: current_color)
      |> assign(public_url: build_public_url(slug))

    {:ok, socket}
  end

  @impl true
  def handle_event(
        "validate",
        %{"event_type" => params},
        socket
      ) do
    changeset = EventType.change_event_type(socket.assigns.event_type, params)
    public_url = build_public_url(get_slug(changeset))

    socket =
      socket
      |> assign(current_color: params["color"])
      |> assign(public_url: public_url)
      |> assign(form: to_form(changeset, action: :validate))

    {:noreply, socket}
  end

  @impl true
  def handle_event("set_color", %{"color" => color}, socket) do
    changeset = EventType.change_event_type(socket.assigns.event_type, %{color: color})

    socket =
      socket
      |> assign(current_color: color)
      |> assign(form: to_form(changeset, action: :validate))

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", %{"event_type" => params}, socket) do
    send(self(), {:submit, params})

    {:noreply, socket}
  end

  defp build_public_url(nil) do
    build_public_url("")
  end

  defp build_public_url(slug) do
    ~p"/#{slug}"
  end

  defp get_slug(%Changeset{changes: %{slug: slug}}), do: slug
  defp get_slug(%Changeset{data: %{slug: slug}}), do: slug
end
