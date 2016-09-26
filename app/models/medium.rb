class Medium < ActiveRecord::Base
  belongs_to :case

  has_attached_file :file, :default_url => "no_item.png"
  validates_attachment_content_type :file, :content_type => /.*/

  # styles: lambda { |a| a.instance.check_file_type}
  # The path of the item that will be shown while the file is loading
  def processing_item_path(item_name)
    "/assets/" + Rails.application.assets.find_asset(item_name).digest_path
  end  


  # process_in_background :item, processing_item_url: lambda { |a| a.instance.processing_item_path("dad.jpg")}


  # IMPORTANT! The ffmpeg library has to added to the server machine. 
  # It can be uploaded from the official website https://www.ffmpeg.org/
  def check_file_type
    if is_image_type?
      {:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }
    elsif is_video_type?
      {
        :medium => { :geometry => "640x360#", :format => 'jpg'},
        :video => {:geometry => "640x360#", :format => 'mp4', :processors => [:transcoder]}
      }
    elsif is_audio_type?
      {
        :audio => {
          :format => "mp3", :processors => [:transcoder]
        }
      }
     # item_file_name = self.basename(:item_file_name, self.extname(:item_file_name))
    else
      {}
    end
  end



  # Method returns true if file's content type contains word 'item', overwise false
  def is_image_type?
    item_content_type =~ %r(image)
  end

  # Method returns true if file's content type contains word 'video', overwise false
  def is_video_type?
    item_content_type =~ %r(video)
  end

  # Method returns true if file's content type contains word 'audio', overwise false
  def is_audio_type?
    item_content_type =~ /\Aaudio\/.*\Z/
  end
end
