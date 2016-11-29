defmodule Asana.Pose do
  use Ecto.Schema

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
end
