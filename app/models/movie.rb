class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R NC-17)
  end

  # for bringing sort in place, this request can be chained like a builder request
  def self.sort_builder(builder, field)
    if field=="title"
      builder.order(:title)
    elsif field=="release"
      builder.order(:release_date)
    else
      builder
    end
  end

  # for bringing ratings filter in place, this request can be chained like a builder request
  def self.with_ratings_builder(builder, filters)
    if filters.length>0
      builder.where(rating: filters)
    else
      builder
    end
  end

  # uses the two builders above and creates a mixture query
  def self.sort_and_ratings_filter(sort, filters)
    builder = all()
    builder = sort_builder(builder, sort)
    builder = with_ratings_builder(builder, filters)
    builder
  end

end
