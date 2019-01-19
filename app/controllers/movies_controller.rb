class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # initially we check if we need to replace some session variables with the params
    if params[:ratings]!=nil and params[:ratings].keys.length > 0
      session[:ratings] = params[:ratings]
    end
    if params[:sort]!=nil
      session[:sort] = params[:sort]
    end
    if session[:ratings]==nil
      session[:ratings] = {}
    end

    # here we check if some params that should have been present but are not present
    len_srating = session[:ratings]==nil ? 0 : session[:ratings].keys.length
    len_prating = params[:ratings]==nil ? 0 : params[:ratings].keys.length
    if (params[:sort]==nil and session[:sort]!=nil) or (len_prating==0 and len_srating>0)
      flash.keep
      return redirect_to sort: session[:sort], ratings: session[:ratings]
    end

    # all ratings is the same
    @all_ratings = Movie.all_ratings

    # if there are some checked ratings, we check all the ratings back as we did previously
    if session[:ratings].keys.length==0
      @checked_ratings = Movie.all_ratings
    else
      @checked_ratings = session[:ratings].keys
    end

    # finally get the movies acknowledging the sort and the filters
    @movies = Movie.sort_and_ratings_filter(session[:sort], session[:ratings].keys)
  end

  def new
    @all_ratings = Movie.all_ratings
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
