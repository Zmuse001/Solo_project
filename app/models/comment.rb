class Comment < ApplicationRecord
  include Visible

  belongs_to :fitness
end
