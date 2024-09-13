class License < ApplicationRecord
  belongs_to :user

  # Options for lic_endorsements checkboxes
  LIC_ENDORSEMENTS = %i[Hazmat Tanker Doubles-Triples Passengers School-Bus]

  # Options for license classes
  def self.lic_classes
    [["Student", "student"], ["Class A", "classA"], ["Class B", "classB"], ["Class C", "classC"]]
  end

  # Options for years experience
  def self.years_exp
    [
    ["Need CDL Training", "Need School"],
    ["In CDL School", "No Exp"],
    ["1 - 5 months", "1-5months"],
    ["6 - 11 months", "6-11months"],
    ["12 - 23 months", "12-23months"],
    ["2 years", "2years"],
    ["3 years", "3years"],
    ["4 years", "4years"],
    ["5+ years", "5+years"],
  ]
  end
end
