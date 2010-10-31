class PostAttachment < ActiveRecord::Base
  belongs_to :post

  has_attached_file :photo, :styles => { :large => "900x600>", :small => "85x85>" },
                    :storage => ENV['S3_BUCKET'] ? :s3 : :filesystem,
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :path => ENV['S3_BUCKET'] ? ":class/:id/:style/:filename" : ":rails_root/public/assets/photos/:id/:style/:basename.:extension",
                    :url => "/assets/photos/:id/:style/:basename.:extension"
end
