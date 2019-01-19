class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R NC-17)
  end

  def self.sort(field)
    if field=="title"
      order(:title)
    elsif field=="release"
      order(:release_date)
    else
      all()
    end
  end

  def self.with_ratings(filters)
    where(rating: filters)
  end

end
