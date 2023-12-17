# frozen_string_literal: true

class Nutrition < ApplicationRecord
  belongs_to :user
  attribute  :status, :integer
  validates :food_name, presence: true
  validates :serving_units, presence: true
  validates :serving_weight_grams, presence: true
  validates :calories, presence: true
  validates :protein, presence: true
  validates :total_fat, presence: true
  validates :total_carbohydrates, presence: true
  validates :sugar, presence: true
end
