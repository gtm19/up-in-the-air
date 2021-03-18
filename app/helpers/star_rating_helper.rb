require "font-awesome-sass"

module StarRatingHelper
  def stars(num)
    num = num.round(1)
    whole_stars = num.floor
    half_stars = ((num - whole_stars) * 2).to_i
    icon("fas", "star", class: "fill-primary") * whole_stars + icon("fas", "star-half") * half_stars
  end

  def chilli(num)
    num = num.round(1)
    whole_stars = num.floor
    half_stars = ((num - whole_stars) * 2).to_i
    icon("fas", "pepper-hot", class: "fill-warning") * whole_stars + icon("fas", "leaf") * half_stars
  end
end
