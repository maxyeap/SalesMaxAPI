class Deal < ApplicationRecord
  belongs_to :lead
  has_many :activities
end
