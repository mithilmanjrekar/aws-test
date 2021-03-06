class VisitorsController < ApplicationController

  #Upload image
  def upload_image

    uploaded_image = params[:file]
    s3_image_url  = get_s3_image_url(uploaded_image)

    #respond with the iamge url 
    render json: {'status' => 200,'s3_image_url' => s3_image_url}

  end 

  #Upload image and get the url back
  def get_s3_image_url(uploaded_image)

	return S3Uploader.upload_image_and_get_url(uploaded_image)

  end	

end
