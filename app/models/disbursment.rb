class Disbursment < ActiveRecord::Base
  belongs_to :case
  validates_presence_of :amount, :details

  has_attached_file :video
  validates_attachment_size :video, less_than: 100.megabytes
  validates_attachment_content_type :video, :content_type => ['video/quicktime', 'video/mp4', 'video/mpeg', 'video/mpeg4', 'video/x-flv', 'video/x-msvideo']

  #after_save :set_recieve_amount

  def set_recieve_amount
  	# binding.pry
  end
end
