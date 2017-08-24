class Tag < ApplicationRecord
  # Direct associations

  belongs_to :user,
             :counter_cache => true

  belongs_to :video

  # Indirect associations

  # Validations

end
