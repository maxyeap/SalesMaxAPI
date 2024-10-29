class Lead < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :activities, through: :deals
end
