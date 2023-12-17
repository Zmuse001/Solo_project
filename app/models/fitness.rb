# frozen_string_literal: true

class Fitness < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  # attribute  :status, :integer
end
