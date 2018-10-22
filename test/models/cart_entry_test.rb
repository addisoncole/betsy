require "test_helper"

describe CartEntry do
  let(:cart_entry) { CartEntry.new }

  it "must be valid" do
    value(cart_entry).must_be :valid?
  end
end
