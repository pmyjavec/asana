defmodule Asana.AsanaRepo.Migrations.CreatePoses do
  use Ecto.Migration

  def change do
    create table(:poses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :difficulty_rating , :decimal
      add :keywords, :text

      timestamps
    end

  end
end
