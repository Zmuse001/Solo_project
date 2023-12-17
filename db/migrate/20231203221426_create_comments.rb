# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body

      t.timestamps
    end
  end
end
