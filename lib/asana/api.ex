defmodule Asana.API do
  @doc """
  The core of the API. This module is esentially he presentation layer of the service.
  """
  use Plug.Router
  use Plug.ErrorHandler

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
    links = %{
      "self": burl(conn),
      poses: burl(conn) <> "poses",
      search: burl(conn) <> "search"
    }
    conn |> json(%{jsonapi: %{version: "1.0"}, links: links, data: []})
  end

  get "/poses" do
    poses = Asana.Repo.all(Pose)
    resp_data = Enum.map(poses, fn(p) -> Response.new(p.id, burl(conn) <> "/" <> p.id) end)

    conn |> json(%{data: resp_data})
  end

  get "/poses/:id" do
    resp_data = Response.new(id, burl(conn))
    conn |> json(%{data: [resp_data]})
  end

  get "/search" do
    conn |> fetch_query_params

    q = conn.query_params["q"] || ""
    poses = Asana.Pose.search(q)
    resp_data = Enum.map(poses, fn(p) -> Response.new(p.id, burl(conn) <> "/" <> p.id) end)

    conn |> json(%{data: [resp_data]})
  end

  match _ do
    error = %{
      status: "404",
      title: "Not found",
      detail: "The specified resource could not be found.",
      source: %{"pointer": burl(conn)}
    }

    conn
      |> put_status(:not_found)
      |> json(%{errors: [error]})
  end


  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    error = %{
      status: "500",
      title: "Server Error Occured",
      detail: "An undefined error occured.",
      source: []
    }

    conn
      |> put_status(500)
      |> json(%{errors: [error]})
  end
end
