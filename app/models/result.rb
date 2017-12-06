class Result < ApplicationRecord
  belongs_to :provider
  has_one :user, through: :provider

  scope :photos, -> { where(category: 'photo') }
  scope :texts, -> { where(category: 'link' || 'status' || 'offer') }
  scope :videos, -> { where(category: 'video') }
end
