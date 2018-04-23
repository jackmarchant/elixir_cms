defmodule ElixirCMS.Router do
  @moduledoc """
  A `Plug.Router`. This module is meant to be plugged into host applications.
  """

  use Plug.Router

  plug Plug.Logger, log: :debug

  plug Plug.Static,
    gzip: true,
    at: "/assets",
    from: :elixir_cms

  plug Plug.Parsers, parsers: [:urlencoded]
  plug Plug.MethodOverride

  plug :match
  plug :dispatch

  @doc false
  def init(opts), do: super(opts)

  @doc false
  def call(conn, opts) do
    conn = extract_namespace(conn, opts)
    super(conn, opts)
  end

  get "/" do
    conn
    |> html_resp(200, ElixirCMS.Templates.index(%{conn: conn}))
  end

  match _ do
    send_resp(conn, 404, "")
  end

  defp html_resp(conn, status, body) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(status, body)
  end

  defp extract_namespace(conn, opts) do
    ns = opts[:namespace] || ""
    Plug.Conn.assign(conn, :namespace, "/" <> ns)
  end
end