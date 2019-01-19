module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def should_highlight(field)
    if params[:sort].to_s == field
      return 'hilite'
    else
      return nil
    end
  end

  def is_checked(checked_ratings, rating)
    checked_ratings.include? rating
  end
end
