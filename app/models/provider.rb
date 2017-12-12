class Provider < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy
end
