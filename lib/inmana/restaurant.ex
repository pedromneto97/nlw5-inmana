defmodule Inmana.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Inmana.Supply

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :name]

  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  schema "restaurants" do
    field :email, :string
    field :name, :string

    has_many :supplies, Supply

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 2)
    |> validate_format(
      :email,
      ~r/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i
    )
    |> unique_constraint([:email])
  end
end
