class VisitorsController < ApplicationController

	def save_screenshot_to_s3(image_location, folder_name,user_id)
		service = AWS::S3.new(:access_key_id =>  ENV["ACCESS_KEY_ID"],
		                      :secret_access_key =>  ENV["SECRET_ACCESS_KEY"])
		bucket_name = "app-images"

		if(service.buckets.include?(ENV["S3_BUCKET"]))
		  bucket = service.buckets[ENV["S3_BUCKET"]]
		else
		  bucket = service.buckets.create(ENV["S3_BUCKET"])
		end

		bucket.acl = :public_read
		key = folder_name.to_s + "/" + File.basename(image_location)
		s3_file = service.buckets[bucket_name].objects[key].write(:file => image_location)
		s3_file.acl = :public_read
		user = User.where(id: user_id).first
		user.image = s3_file.public_url.to_s
		user.save
  end   

  def upload_image
  puts AWS::S3.new(:access_key_id =>  ENV["ACCESS_KEY_ID"],
		                      :secret_access_key =>  ENV["SECRET_ACCESS_KEY"])
  # begin
  #   image = S3Store.new(params[:upload][:image]).store
   
	 #  rescue Exception => e
	   
	 #  end
  end 
end
