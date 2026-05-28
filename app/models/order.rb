# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, paid: 1, shipped: 2, canceled: 3 }

  validates :status, :total_price, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :customer_name, :customer_email, :shipping_address, presence: true
  validate :must_have_items

  accepts_nested_attributes_for :order_items

  before_validation :copy_customer_data, on: :create
  before_validation :calculate_total_price

  def recalculate!
    calculate_total_price
    save!
  end

  private

  def copy_customer_data
    self.customer_name ||= user&.name
    self.customer_email ||= user&.email
  end

  def calculate_total_price
    self.total_price = order_items.sum do |item|
      unit_price = item.unit_price || item.product&.price || 0
      item.quantity.to_i * unit_price.to_d
    end
  end

  def must_have_items
    errors.add(:order_items, "can't be blank") if order_items.empty?
  end
end
