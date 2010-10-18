class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :post_attachments, :dependent => :destroy

  validates_presence_of :body, :title, :post_type

  def all_but_first_attachment_in_groups_of(groups_of)
    the_rest = post_attachments
    the_rest.delete_at(0)
    in_groups_of(groups_of,the_rest)
  end

  def in_groups_of(groups_of,posts = post_attachments)
    count = -1
    posts.group_by do |attachment|
      count+=1
      (count/groups_of).to_i
    end
  end

  def picture_type?
    self.post_type == "Picture"
  end
end
