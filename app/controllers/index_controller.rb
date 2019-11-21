class IndexController < ApplicationController
  before_action :authenticate_user!, :except => [:discover, :profile]
  def editUserProfile
    @photos = current_user.photos.all
    @albums = current_user.albums.all

  end
  def feed
    @photos = current_user.followings.map { |user| user.photos.all  }.flatten!
    @albums = current_user.followings.map { |user| user.albums.all  }.flatten!

  end
  def profile
    @profileUser = User.where(id: params[:id]).first
    @profilePhotos = @profileUser.photos.all
    @profileAlbums = @profileUser.albums.all

  end
  def discover

      @photos = Photo.all.order(updated_at: :desc)
      @albums = Album.all.order(updated_at: :desc)

  end

  def unfollow
    f = Follow.where(follower_id: params["follower_id"]).where(following_id: params["following_id"]).first
    if f.delete
      redirect_to request.referrer
    end
  end

  def follow
    f = Follow.create(follower_id: params["follower_id"], following_id: params["following_id"])
    if f.save
      redirect_to request.referrer
    end
  end


  def like_photo
    @post = Photo.find_by id: params[:id_photo]
    puts current_user.liked? @post
    if current_user.liked? @post
      @post.disliked_by current_user
    else
      @post.liked_by current_user
    end
  end



  def like_album
    @post = Album.find_by id: params[:id_album]
    puts current_user.liked? @post
    if current_user.liked? @post
      @post.disliked_by current_user
    else
      @post.liked_by current_user
    end
  end



end
