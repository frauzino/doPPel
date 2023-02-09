class Booking < ApplicationRecord
  belongs_to :doppelganger
  belongs_to :user
  # has_one :agent, through: :doppelganger, source: :user

  validates :start_date, presence: true, comparison: { greater_than: Date.today }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :address, presence: true
  validates :status, presence: true

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2,
    canceled: 3
  }
end
