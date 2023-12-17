# frozen_string_literal: true

class Profile < ApplicationRecord
  include Visible
  belongs_to :user
  attribute  :status, :integer
end
