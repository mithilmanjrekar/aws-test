class VisitorsController < ApplicationController

  def upload_image

	reponse_status = 200
	response_message = "Success!"

    msg = { :status => reponse_status, :message => response_message }
    string  = S3Uploader.s3_solution_test

 #    uploaded_io = params[:file]
	# dir = Rails.root.join('public', uid)
	# Dir.mkdir(dir) unless Dir.exist?(dir)
	# File.open(dir.join(uploaded_io.original_filename), 'wb') do |file|
	# 	file.write(uploaded_io.read)
	# end
       
    render json: params[:file].to_s
  end 

end
