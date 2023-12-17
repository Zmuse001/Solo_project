# frozen_string_literal: true

class CreateNutritions < ActiveRecord::Migration[7.1]
  def change
    create_table :nutritions do |t|
      t.string :food_name
      t.integer :serving_units
      t.integer :serving_weight_grams
      t.integer :protein
      t.integer :calories
      t.integer :total_fat
      t.integer :total_carbohydrates
      t.integer :sugar
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
