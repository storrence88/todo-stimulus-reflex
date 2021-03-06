# frozen_string_literal: true

class Task < ApplicationRecord
  acts_as_list scope: [:list_id, { completed_at: nil }], top_of_list: 0

  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :completer, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :list

  has_many :comments, -> { order(created_at: :asc) }, as: :commentable, dependent: :destroy

  delegate :name, to: :assignee, prefix: true, allow_nil: true
  delegate :name, to: :completer, prefix: true, allow_nil: true

  scope :complete, -> { where.not(completed_at: nil).order(updated_at: :asc) }
  scope :incomplete, -> { where(completed_at: nil).order(position: :asc) }

  validates :name, presence: true

  def complete?
    completed_at.present?
  end
end
