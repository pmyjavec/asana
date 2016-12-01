defmodule Asana.Helper.Response do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      import Plug.Conn
    end
  end

  @doc """
  Easily generate JSON responses in the correct format and set headers approriately
  """
  def json(%Plug.Conn{}=conn, data) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(conn.status || 200, Poison.encode_to_iodata!(data))
    |> Plug.Conn.halt
  end

  @doc """
  Returns the "base_url", example http://localhost:4000/
  """
  def burl(c) do
    port = case c.port do
      443  ->
       ""
      80 ->
       ""
      _ ->
        ":" <> Integer.to_string(c.port)
    end

    Atom.to_string(c.scheme) <> "://" <> c.host <> port <> c.request_path
  end
end
