class VisitorsController < ApplicationController

  def upload_image
  	
    uploaded_image = params[:file]
    s3_image_url  = S3Uploader.upload_image_and_get_url(uploaded_image)

    render json: s3_image_url
  end 

end
