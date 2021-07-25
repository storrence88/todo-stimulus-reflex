# frozen_string_literal: true

class List < ApplicationRecord
  has_many :tasks, ->{ incomplete_first.order(position: :asc) }, dependent: :destroy
  validates :name, presence: true
end
