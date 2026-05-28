# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than_or_equal_to: 0 }
  validate :product_must_be_active, on: :create
  validate :product_has_stock, on: :create

  before_validation :copy_product_price, on: :create
  before_validation :calculate_total_price
  after_create :decrement_product_stock

  private

  def copy_product_price
    self.unit_price ||= product&.price
  end

  def calculate_total_price
    self.total_price = quantity.to_i * unit_price.to_d
  end

  def product_has_stock
    return if product.blank? || quantity.blank?

    errors.add(:quantity, "is greater than available stock") if quantity > product.stock_quantity
  end

  def product_must_be_active
    return if product.blank? || product.active?

    errors.add(:product, "is not available")
  end

  def decrement_product_stock
    product.lock!
    product.decrement!(:stock_quantity, quantity)
  end
end
