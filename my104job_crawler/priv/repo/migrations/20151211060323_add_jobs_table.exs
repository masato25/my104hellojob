defmodule My104jobCrawler.Repo.Migrations.AddJobsTable do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :company_name, :string
      add :job_name, :string
      add :area, :string
      add :create_at, :date
      add :sal_low, :integer
      add :sal_high, :integer
      add :welfare, :text
      add :j, :string
      add :c, :string
      add :job_cat, :string
      timestamps
    end
    create unique_index(:jobs, [:c])
  
  end
end
