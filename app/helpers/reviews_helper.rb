module ReviewsHelper

  def convert_review_rating_to_smileys(rating)
    case rating
    when 1
      "\u{1F92E}"
    when 2
      "\u{1F60D}\u{1F60D}"
    when 3
      "\u{1F60D}\u{1F60D}\u{1F60D}"
    when 4
      "\u{1F60D}\u{1F60D}\u{1F60D}\u{1F60D}"
    when 5
      "\u{1F525}\u{1F525}\u{1F525}\u{1F525}\u{1F525}"
    end
  end
end
