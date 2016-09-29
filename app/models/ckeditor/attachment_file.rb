class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    url: '/ckeditor_assets/attachments/:id/:filename',
                    path: ':rails_root/public/ckeditor_assets/attachments/:id/:filename'

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 100.megabytes
  validates_attachment_content_type :data, :content_type => ['video/quicktime', 'video/mp4', 'video/mpeg', 'video/mpeg4']

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end