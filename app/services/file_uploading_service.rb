class FileUploadingService

  # upload file attachments
  def upload_file(object, file)
    encoded_string = Base64.encode64(File.open(file.path, "rb").read)
    object.data = encoded_string
    object.filename  = file.original_filename
    object.extension = file.original_filename.split('.').last
    object.mime_type = file.content_type
    object.save
  end
end