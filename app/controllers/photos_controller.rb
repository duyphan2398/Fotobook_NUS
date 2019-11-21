class PhotosController < ApplicationController

  def index
    @photos = Photo.order('created_at')
  end


  def new
    @photo = Photo.new
  end
  def show
    @photo = Photo.find(params[:id])
  end
  def edit
    @photo = Photo.find(params[:id])
  end
 #Create action ensures that submitted photo gets created if it meets the requirements
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      flash[:notice] = "Successfully added new photo!"
      render :new
    else
      flash[:alert] = "Error adding new photo!"
      render :new
    end
  end
  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:notice] = "Successfully deleted photo!"
      redirect_to "/userProfile"
    else
      flash[:alert] = "Error deleting photo!"
      render :edit
    end
  end
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      flash[:notice] = 'Upload was successfully updated'
      redirect_to "/userProfile"
    else
      flash[:alert] = "Error updating photo!"
      render :edit
    end
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end
    #Permitted parameters when creating a photo. This is used for security reasons.
    def photo_params
      params.require(:photo).permit(:title,:description,:sharing_mode, :image)
    end

end
