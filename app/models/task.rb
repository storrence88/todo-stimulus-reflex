# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :list

  scope :incomplete_first, -> { order(completed_at: :desc) }

  validates :name, presence: true

  def complete?
    completed_at.present?
  end
end
