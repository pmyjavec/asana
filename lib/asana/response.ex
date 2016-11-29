defmodule Asana.Response do
  alias Asana.Repo
  alias Asana.Pose

  @doc """
  Response struct, builds a response according to jsonapi.org spec.
  """

  @derive [Poison.Encoder]
  @enforce_keys [:id]
  defstruct [
    :id,
    attributes: %Pose{},
    links: %{},
    type: "",
  ]

  def new(id, burl) do
    pose = Repo.get!(Pose, id)

    %Asana.Response{
      id: id,
      attributes: pose,
      links: %{self: burl},
      type: "pose"
    }
  end
end
