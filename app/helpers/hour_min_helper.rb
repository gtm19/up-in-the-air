module HourMinHelper
  def min_convert(minutes)
    hours = minutes / 60
    rest = minutes % 60
    "#{hours}hrs #{rest}mins"
  end
end
