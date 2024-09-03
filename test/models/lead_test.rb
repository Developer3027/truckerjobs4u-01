# test/models/lead_test.rb
# Testing functionality of Lead model

require "test_helper"

class LeadTest < ActiveSupport::TestCase
  # test that lead can be created
  test "should create a valid lead" do
    lead = Lead.new(first_name: "John",
                    last_name: "Doe",
                    lead_email: "johndoe@example.com",
                    phone: "1234567890",
                    location: "New York, NY",
                    note: "Test lead",
                    pp_check: true)
    assert lead.save, "Saved lead"
  end

  # test "should not create a lead with invalid email" do
  #   lead = Lead.new(first_name: "John",
  #                   last_name: "Doe",
  #                   lead_email: "invalid_email",
  #                   phone: "1234567890",
  #                   location: "New York, NY",
  #                   note: "Test lead",
  #                   pp_check: true)
  #   refute lead.save, "Did not save lead"
  # end

  # test that lead cannot be created without required fields
  test "should not create a lead with missing required fields" do
    lead = Lead.new(first_name: "",
                    last_name: "",
                    lead_email: "",
                    phone: "",
                    location: "",
                    note: "",
                    pp_check: "")
    refute lead.save, "Did not save lead"
  end
end
