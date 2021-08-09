# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :team

  accepts_nested_attributes_for :team

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
