defmodule Discuss.Topic do
   use Discuss.Web, :model

   schema "topcis" do # topics == table in DB
     field :title, :string # column with name 'title' which is of type 'string'
   end

   # this functions creates a (Ecto) changeset = represents the structure how we wanna update the DB
   ##  Ecto.Changeset
   #    <
   #      action: nil,
   #      changes: %{title: "Elixir is awesome"},
   #      errors: [],
   #      data: #Discuss.Topic<>,
   #      valid?: true
   #    >
   def changeset(struct, params \\ %{}) do
    # struct = represents a record which we wanna save in DB (kinda container)
    # params = contains properties we wanna update in 'struct' - here 'title'
      struct
      |> cast(params, [:title]) # cast -> produces a changeset
      |> validate_required([:title]) # validators -> adds errors to changeset
   end
end
