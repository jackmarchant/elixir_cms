defmodule ElixirCMS.Templates do
  @moduledoc """
  Generate templates and provide them with helper functions
  """

  require EEx

  @templates [
    _head: "_head",
    index: "index",
  ]

  for {fn_name, file_name} <- @templates do
    EEx.function_from_file :def, fn_name, Path.expand("./templates/#{file_name}.html.eex", __DIR__), [:assigns]
  end

  def path(conn, path) do
    Path.join(conn.assigns[:namespace], path)
  end
end