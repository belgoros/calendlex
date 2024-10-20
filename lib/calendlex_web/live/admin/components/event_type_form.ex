defmodule CalendlexWeb.Admin.Components.EventTypeForm do
  @moduledoc false
  use CalendlexWeb, :live_component

  alias Calendlex.EventType

  @colors ~w(red yellow green blue indigo pink purple)

  def update(
        %{
          event_type: %EventType{color: current_color, slug: slug} = event_type,
          changeset: changeset
        },
        socket
      ) do
    socket =
      socket
      |> assign(colors: @colors)
      |> assign(changeset: changeset)
      |> assign(event_type: event_type)
      |> assign(current_color: current_color)
      |> assign(public_url: build_public_url(slug))

    {:ok, socket}
  end

  defp build_public_url(nil) do
    build_public_url("")
  end

  defp build_public_url(slug) do
    ~p"/#{slug}"
  end
end
