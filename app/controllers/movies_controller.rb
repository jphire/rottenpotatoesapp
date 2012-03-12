class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@all_ratings = Movie.ratings

	@checked = Hash[@all_ratings.map {|x| [x, false]}]

	if params[:ratings]
	  wanted_ratings = params[:ratings].keys
	  @checked = params[:ratings]
	  @checked.each do |val|
		#{val} = true
	  end
	else
	  wanted_ratings = @all_ratings
	end
    if params[:link_name] == 'release_date'
	@movies = Movie.find(:all, :conditions => ["rating IN (?)", wanted_ratings], :order => 'release_date')
	@release_date = 'hilite'
	@title = ''
    elsif params[:link_name] == 'title'
	@title = 'hilite'
	@release_date = ''
	@movies = Movie.find(:all, :conditions => ["rating IN (?)", wanted_ratings], :order => 'title')
    else
	@title = ''
	@release_date = ''
	@movies = Movie.where(:rating => wanted_ratings)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
