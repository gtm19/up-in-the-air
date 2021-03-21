require "font-awesome-sass"

module StarRatingHelper
  def stars(num)
    num = num.round(1)
    whole_stars = num.floor
    half_star = ((num - whole_stars) * 2).to_i
    empty_stars = ( 5 - (whole_stars + half_star)).to_i
    # TODO Fix the stars padding
    icon("fa", "star") * whole_stars + icon("fa", "star-half-alt") * half_star + icon("far", "star") * empty_stars
  end
end
