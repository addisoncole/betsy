require "test_helper"

describe Review do
  describe "relations" do

    it "belongs to a product" do
      expect(reviews(:first).product).must_be_instance_of Product
    end

    it "belongs to a user" do
      expect(reviews(:first).user).must_be_instance_of User
    end

  end

  describe "validations" do
    it "must be valid" do
      reviews(:first).must_be :valid?
    end

    it "is not valid without a rating" do
      new_rating = Review.new(rating: nil, comment: "newwww comment")

      expect(new_rating.valid?).must_equal false
      expect ( new_rating.errors.messages ).must_include :rating
    end

    it "is not valid if rating is greater than 5" do
      new_rating = Review.new(rating: 11, comment: "newwww comment")

      expect(new_rating.valid?).must_equal false
      expect( new_rating.errors ).must_include :rating
    end

    it "is not valid if rating is 0" do
      new_rating = Review.new(rating: 0, comment: "newwww comment")

      expect(new_rating.valid?).must_equal false
      expect( new_rating.errors ).must_include :rating
    end

    it "is not valid if rating is negative number" do
      new_rating = Review.new(rating: -5, comment: "newwww comment")

      expect(new_rating.valid?).must_equal false
      expect( new_rating.errors ).must_include :rating
    end

    it "is not valid if rating is a string/alphabet" do
      new_rating = Review.new(rating: "a", comment: "newwww comment")

      expect(new_rating.valid?).must_equal false
      expect( new_rating.errors ).must_include :rating
    end
  end
end
