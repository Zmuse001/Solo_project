# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.integer :height
      t.integer :weight
      t.string :sex
      t.string :activity_level
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
