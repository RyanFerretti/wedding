require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def new_post(attributes = {})
    attributes[:title] ||= 'this is a title'
    attributes[:body] ||= 'this is the body'
    post = Post.new(attributes)
    post.valid? # run validations
    post
  end

  def test_require_title
    assert new_post(:title => '').errors.on(:title)
  end

  def test_require_body
    assert new_post(:body => '').errors.on(:body)
  end
end
