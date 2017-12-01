class S3Uploader 

  def self.create_new_resource

     # Create an instance of the Aws::S3::Resource class
	 return Aws::S3::Resource.new(credentials: Aws::Credentials.new(),region: 'us-east-1')
  
  end	

  def self.get_object_by_bucket_name(bucket_name , image, s3)

  	 file_type =  Rails.root.join("public/download.jpeg").extname
	 filename = SecureRandom.uuid
	 upload_key = filename + file_type 
	 path = 'photos/'
	 return s3.bucket(bucket_name).object(path + upload_key)
     
  end	

 
  def self.upload_image_and_get_url(image)
		
	s3 = create_new_resource
	obj = get_object_by_bucket_name('mithil-test' , image,s3)
	obj.upload_file(Rails.root.join("public/download.jpeg").open)

	return obj.public_url

  end

end