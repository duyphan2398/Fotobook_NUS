class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
  @album = Album.new(album_params)
  @album.user_id = current_user.id
    if @album.save

      if params[:images]
        params[:images].each { |image|
        @album.pics.create(image: image)
      }
      end
      flash[:notice] = "Successfully added new album!"
      redirect_to "/userProfile"
    else
      flash[:alert] = "Error adding new album!"
      render :new
    end
  end

  def update
    if @album.update(album_params)
      if params[:images]
        params[:images].each do |image|
          existing_image = @album.pics.find {|pic| pic.image_file_name ==image.original_filename}
          @album.pics.create(image: image) unless existing_image
        end
      end
      flash[:notice] = "Successfully updated the album!"
      redirect_to "/userProfile"
    else
      flash[:alert] = "Error updating the album!"
      render :edit
    end
  end

  def destroy
    if  @album.destroy
      flash[:notice] = "Successfully destroyed the album!"
      redirect_to "/userProfile"
    else
      flash[:alert] = "Error destroying the album!"
      render :edit
    end
  end
  private
    def set_album
      @album = Album.find(params[:id])
    end
    def album_params
      params.require(:album).permit(:title, :description, :sharing_mode)
    end
end