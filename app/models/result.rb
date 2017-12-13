class Result < ApplicationRecord
  belongs_to :provider
  has_one :user, through: :provider

  scope :photos, -> { where(category: 'photo') }
  scope :texts, -> { where(category: 'post') }
  scope :videos, -> { where(category: 'video') }
  scope :pages, -> { where(category: 'page') }

end
