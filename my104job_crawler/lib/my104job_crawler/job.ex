defmodule My104jobCrawler.Job do
  use Ecto.Model
  import Ecto.Changeset
  import Ecto.Queryable
  
  schema "jobs" do
    field :company_name, :string
    field :job_name, :string
    field :area, :string
    field :create_at, Ecto.Date
    field :sal_low, :integer
    field :sal_high, :integer
    field :welfare, :string
    field :j, :string
    field :c, :string
    field :job_cat, :string

    timestamps
  end

  @required_fields ~w(company_name job_name area create_at sal_low sal_high welfare j c job_cat)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:c)
  end
end
