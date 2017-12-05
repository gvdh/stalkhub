class Result < ApplicationRecord
  belongs_to :provider
  has_one :user, through: :provider
end
