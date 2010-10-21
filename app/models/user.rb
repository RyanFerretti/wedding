class User < ActiveRecord::Base
  has_many :posts

  has_attached_file :avatar,
                    :styles => { :small => "85x85>" },
                    :storage => ENV['S3_BUCKET'] ? :s3 : :filesystem,
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :path => ENV['S3_BUCKET'] ? ":class/:id/:style/:filename" : ":rails_root/public/assets/avatars/:id/:style/:basename.:extension",
                    :url => "/assets/avatars/:id/:style/:basename.:extension"

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :first_name, :last_name, :username, :email, :avatar, :password, :password_confirmation, :identity_url #, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at 
  
  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :first_name, :on => :create
  validates_presence_of :last_name, :on => :create  
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def admin?
    true
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
