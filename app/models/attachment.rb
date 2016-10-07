class Attachment < ActiveRecord::Base
	belongs_to :case

  has_attached_file :file, styles: lambda { |a| a.instance.check_file_type}, :default_url => "no_file.png"
  validates_attachment_content_type :file, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio', "application/zip", "application/msword", "application/vnd.ms-office", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "image/png", "image/jpeg", "application/pdf", 'video/quicktime', 'video/mp4', 'video/mpeg', 'video/mpeg4', 'video/x-flv', 'video/x-msvideo']

  def check_file_type
    if is_image_type?
      {:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }
    else
    	{}	
    end
  end



  # Method returns true if file's content type contains word 'file', overwise false
  def is_image_type?
    file_content_type =~ %r(image)
  end

  # Method returns true if file's content type contains word 'video', overwise false
  def is_video_type?
    file_content_type =~ %r(video)
  end

  # Method returns true if file's content type contains word 'audio', overwise false
  def is_audio_type?
    file_content_type =~ /\Aaudio\/.*\Z/
  end

  def is_doc_type?
    file_content_type =~ %r(application/zip application/msword application/vnd.ms-office application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
  end
end
