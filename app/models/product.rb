# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :restrict_with_error

  validates :name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :available, -> { where(active: true).where("stock_quantity > 0") }
  scope :ordered, -> { order(:name) }
end
