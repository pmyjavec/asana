defmodule Asana.Pose do
  use Ecto.Schema
  import Ecto.Query
  alias Asana.Repo

  # weather is the DB table
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, only: [:id, :name, :description, :difficulty_rating, :type, :links]}
  schema "poses" do
    field :name, :string, null: false
    field :description, :string
    field :difficulty_rating, :decimal # Difficult rating out of 5
    field :keywords, :string  # Keywords for pose search

    timestamps
  end

  @required_fields ~w(name description difficulty_rating)
  @optional_fields ~w(keywords)

  def search(term) do
    query = from(u in Asana.Pose, where: fragment("to_tsvector(keywords || ' ' || name || ' ' || description) @@ to_tsquery(?)", ^term))
    Repo.all query
  end
end
