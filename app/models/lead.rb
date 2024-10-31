class Lead < ApplicationRecord
  belongs_to :user
  has_many :deals, dependent: :destroy
  has_many :activities, through: :deals, dependent: :destroy
end
