class S3Uploader 

   BUCKET =  ENV["S3_BUCKET"].freeze

  def initialize file
    @file = file
    @s3 = AWS::S3.new
    @bucket = @s3.buckets[ ENV["S3_BUCKET"]]
  end

  def store
    @obj = @bucket.objects[filename].write(@file.tempfile, acl: :public_read)
    self
  end

  def url
    @obj.public_url.to_s
  end

  private
  
  def filename
    @filename ||= @file.original_filename.gsub(/[^a-zA-Z0-9_\.]/, '_')
  end

  def upload_image_to_s3(image_file)
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

	# require 'aws-sdk-s3'

	# s3 = Aws::S3::Resource.new(region:'us-west-2')
	# obj = s3.bucket('bucket-name').object('key')

	# # string data
	# obj.put(body: 'Hello World!')

	# # IO object
	# File.open('source', 'rb') do |file|
	# obj.put(body: file)
  end

  def actual_job
		# Create an instance of the Aws::S3::Resource class
		s3 = Aws::S3::Resource.new(
			  credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"]),
			  region: 'us-east-1'
			)

		# Reference the target object by bucket name and key.
		# Objects live in a bucket and have unique keys that identify the object.
		obj = s3.bucket('your-bucket-name').object(file_name)
		obj.upload_file(upload_file, { acl: 'public-read' })  # http://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html

		# Returns Public URL to the file
		obj.public_url

		# obj = s3.bucket('bucket-name').object('key')

		# # from a string
		# obj.put(body:'Hello World!')

		# # from an IO object
		# File.open('/source/file', 'rb') do |file|
		#   obj.put(body:file)
		# end
  end

  
end
