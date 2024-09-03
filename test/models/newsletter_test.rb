require "test_helper"

class NewsletterTest < ActiveSupport::TestCase
  # test if newsletter is created with no email
  test "should not save newsletter without email" do
    newsletter = Newsletter.new
    assert_not newsletter.save
  end

  # test if newsletter is created with email
  test "should save newsletter with email" do
    newsletter = Newsletter.new
    newsletter.newsletter_email = "a@a.com"
    assert newsletter.save
  end

end
