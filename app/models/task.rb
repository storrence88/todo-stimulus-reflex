# frozen_string_literal: true

class Task < ApplicationRecord
  acts_as_list scope: [:list_id, { completed_at: nil }], top_of_list: 0

  belongs_to :list

  scope :incomplete_first, -> { order(completed_at: :desc) }

  validates :name, presence: true

  def complete?
    completed_at.present?
  end
end
