class PostAttachment < ActiveRecord::Base
  belongs_to :post
  has_attached_file :photo, :styles => { :large => "900x600>", :small => "85x85>" },
                    :url  => "/assets/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
end
