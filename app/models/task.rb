# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
end
