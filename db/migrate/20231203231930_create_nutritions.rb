class CreateNutritions < ActiveRecord::Migration[7.1]
  def change
    create_table :nutritions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
