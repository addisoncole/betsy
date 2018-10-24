module ReviewsHelper

  def convert_review_rating_to_smileys(rating)
    case rating
    when 1
      "🤬"
    when 2
      "😍😍"
    when 3
      "😍😍😍"
    when 4
      "😍😍😍😍"
    when 5
      "😍😍😍😍😍"
    end
  end
end
