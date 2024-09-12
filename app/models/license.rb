class License < ApplicationRecord
  belongs_to :user

  LIC_ENDORSEMENTS = %i[Hazmat Tanker Doubles-Triples Passengers School-Bus]
end
