class Feed < ApplicationRecord
  has_many :items
  has_many :fetches

  enum status: {active: 0, flaky: 2, inactive: 3}
end
