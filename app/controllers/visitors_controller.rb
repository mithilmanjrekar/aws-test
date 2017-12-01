class VisitorsController < ApplicationController

  #Upload image
  def upload_image

    uploaded_image = params[:file]
    s3_image_url  = get_s3_image_url(uploaded_image)
    binding.pry
    #respond with the iamge url 
    render json: s3_image_url

  end 

  #Upload image and get the url back
  def get_s3_image_url(uploaded_image)

	return S3Uploader.upload_image_and_get_url(uploaded_image)

  end	

end
