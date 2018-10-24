require "test_helper"

describe Review do
  it "must be valid" do
    reviews(:first).must_be :valid?
  end

  describe 'relations' do

    it "belongs to a product" do
      expect(reviews(:first).product).must_be_instance_of Product
    end

    it "belongs to a user" do
      expect(reviews(:first).user).must_be_instance_of User
    end

  end
end
