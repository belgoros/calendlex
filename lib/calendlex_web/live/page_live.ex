defmodule CalendlexWeb.PageLive do
  use CalendlexWeb, :live_view

  import CalendlexWeb.EventTypeComponents

  @impl true
  def mount(_params, _session, socket) do
    event_types = Calendlex.available_event_types()

    {:ok, assign(socket, event_types: event_types), temporary_assigns: [event_types: []]}
  end
end
