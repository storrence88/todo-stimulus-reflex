# frozen_string_literal: true

class List < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
end
