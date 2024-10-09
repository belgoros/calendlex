defmodule CalendlexWeb.Admin.EventTypesLive do
  use CalendlexWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [event_types: []]}
  end
end
