class Movie < ActiveRecord::Base
  def self.sort(field)
    if field=="title"
      order(:title)
    elsif field=="release"
      order(:release_date)
    else
      all()
    end
  end

end
