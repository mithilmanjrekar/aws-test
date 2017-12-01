class S3Uploader 

  def create_new_resource
     # Create an instance of the Aws::S3::Resource class
	 return Aws::S3::Resource.new(credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"]),region: 'us-east-1')
  end	

  def get_object_by_bucket_name(bucket_name , image, s3)
  	 # Reference the target object by bucket name and key.
  	 # Objects live in a bucket and have unique keys that identify the object.
  	 extname = File.extname(image)
     filename = "#{SecureRandom.uuid}#{extname}"
     upload_key = Pathname.new(prefix).join(filename).to_s
     
     return s3.bucket('your-bucket-name').object(upload_key)
  end	

  def upload_image(upload_file , obj)
  	 # Upload file to the object bucket
  	 return obj.upload_file(upload_file, { acl: 'public-read' })
  end	

  def upload_image_and_get_url(image)
		
	s3 = create_new_s3_resource
	obj = get_s3_object_by_bucket_name(ENV["BUCKET_NAME"] , image,s3)
	obj = obj.upload_image(image,obj)

	return obj.public_url
  end

end