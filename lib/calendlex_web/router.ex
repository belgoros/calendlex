defmodule CalendlexWeb.Router do
  use CalendlexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CalendlexWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :public, on_mount: CalendlexWeb.InitAssigns do
    scope "/", CalendlexWeb do
      pipe_through :browser

      live "/", PageLive
      live "/:event_type_slug", EventTypeLive
      live "/:event_type_slug/:time_slot", ScheduleEventLive
      live "/events/:event_type_slug/:event_id", EventsLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CalendlexWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:calendlex, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
