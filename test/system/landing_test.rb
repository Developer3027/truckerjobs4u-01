require "application_system_test_case"

class LandingTest < ApplicationSystemTestCase
  # test slogan in hero section
  test "visiting the index hero" do
    visit "/"

    # Assert the span text is correct
    assert_selector "span", text: "Steer your career in the right direction."
  end

  # test hero CTA goes to contact form
  test "clicking on the hero CTA takes you to the contact section" do
    visit "/"

    # Find the call to action button in the hero section
    hero_cta = find('a[href="#contact"]')

    # Click on the call to action button
    hero_cta.click

    # Assert that the current path is the contact section
    assert page.current_url.include?("#contact")
  end

  # ensure there are 2 checkboxes correctly named
  test "there are 2 checkboxes" do
    visit "/"

    # Assert that there are 2 checkboxes
    assert_selector "input[type='checkbox'][name='newsletter[pp_check]']"
    assert_selector "input[type='checkbox'][name='lead[pp_check]']"
  end

  # ensure both pp checkboxs are checked
  test "the privacy policy checkbox is checked" do
    visit "/"

    # Find the newsletter checkbox
    newsletter = find('input[type="checkbox"][name="newsletter[pp_check]"]')
    # Find the lead checkbox
    lead = find('input[type="checkbox"][name="lead[pp_check]"]')


    # Assert that the checkboxs are checked
    assert newsletter.checked?
    assert lead.checked?
  end

  # Ensure the company name shows 4 times in about section
  test "should have the phrase 'TruckerJobs4u.com' 4 times in the about section" do
    visit "/"

    within 'section#about' do
      paragraphs = all('p')
      count = 0
      paragraphs.each do |paragraph|
        count += paragraph.text.scan("TruckerJobs4u.com").length
      end
      assert_equal 4, count
    end
  end
end
