require "test_helper"

# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.integer "card_number"
# t.string "card_expiration"
# t.integer "CVV"
# t.integer "billing_zip_code"
# t.string "shipping_address"
# t.string "email"
# t.string "address"
# t.string "status"

# An Order must have one or more Order Items

describe Order do
  let(:order) { Order.new }

  it "must be valid" do
    value(order).must_be :valid?
  end
end
