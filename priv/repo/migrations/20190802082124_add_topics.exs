defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topcis) do
      add :title, :string
    end
  end
end
