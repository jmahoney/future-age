class Feed < ApplicationRecord
  has_many :items

  enum status: {active: 0, flaky: 2, inactive: 3}
end
