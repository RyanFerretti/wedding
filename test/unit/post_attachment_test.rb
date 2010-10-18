require 'test_helper'

class PostAttachmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PostAttachment.new.valid?
  end
end
