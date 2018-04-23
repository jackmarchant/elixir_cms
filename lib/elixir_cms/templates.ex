defmodule ElixirCMS.Templates do
  @moduledoc """
  Templates to serve up content in the Admin
  """

  require EEx

  @templates [
    _head: "_head",
    index: "index",
  ]

  for {fn_name, file_name} <- @templates do
    EEx.function_from_file :def, fn_name, Path.expand("./templates/#{file_name}.html.eex", __DIR__), [:assigns]
  end
end