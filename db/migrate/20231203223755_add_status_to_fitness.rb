class AddStatusToFitness < ActiveRecord::Migration[7.1]
  def change
    add_column :fitnesses, :status, :string
  end
end
