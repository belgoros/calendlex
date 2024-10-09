defmodule CalendlexWeb.LayoutView do
  use CalendlexWeb, :html
  embed_templates "layouts/*"

  alias CalendlexWeb.LiveViewHelpers

  def admin_nav_link_classes(is_current) do
    LiveViewHelpers.class_list([
      {"py-6 font-medium text-gray-400 border-b-2 border-white hover:border-gray-400 hover:text-gray-600",
       true},
      {"text-gray-600 border-blue-500 hover:text-gray-600 hover:border-blue-500", is_current}
    ])
  end
end
