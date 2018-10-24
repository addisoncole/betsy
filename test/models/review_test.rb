require "test_helper"

describe Review do
  it "must be valid" do
    reviews(:first).must_be :valid?
  end
end
