# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :users
end
