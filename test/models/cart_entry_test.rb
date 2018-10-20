require "test_helper"

# Must belong to a Product
# Must belong to an Order
# Quantity must be present
# Quantity must be an integer
# Quantity must be greater than 0

describe CartEntry do
  let(:cart_entry) { CartEntry.new }

  it "must be valid" do
    value(cart_entry).must_be :valid?
  end
end
