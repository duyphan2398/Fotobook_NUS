class PicsController < ApplicationController
  def destroy
    pic = Pic.find(params[:id])
    @id = pic.id
    pic.destroy
    respond_to :js
  end
end
