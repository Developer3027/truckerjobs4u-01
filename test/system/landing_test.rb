require "application_system_test_case"

class LandingTest < ApplicationSystemTestCase
  # test slogan in hero section
  test "visiting the index hero" do
    visit "/"
    assert_selector "span", text: "Steer your career in the right direction."
  end

  # test hero CTA goes to contact form
end
