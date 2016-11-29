defmodule Asana.API do
  @doc """
  The core of the API. This module is esentially he presentation layer of the service.
  """
  use Plug.Router
  use Asana.Helper.Response

  alias Asana.Pose
  alias Asana.Response

  plug Plug.Logger, log: :info
  plug Plug.Parsers,  parsers: [:urlencoded, :json],
                      pass:  ["application/json"],
                      json_decoder: Poison

  plug :match
  plug :dispatch

  get "/" do
    links = %{"self": burl(conn), poses: burl(conn) <> "poses" }
    conn |> json(%{jsonapi: %{version: "1.0"}, links: links, data: []})
  end

  get "/poses" do
    poses = Asana.Repo.all(Pose)
    resp_data = Enum.map(poses, fn(p) -> Response.new(p.id, burl(conn)) end)

    conn |> json(%{data: resp_data})
  end

  get "/poses/:id" do
    resp_data = Response.new(id, burl(conn))
    conn |> json(%{data: [resp_data]})
  end
end
