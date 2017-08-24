class Comment < ApplicationRecord
  # Direct associations

  belongs_to :user

  belongs_to :video,
             :counter_cache => true

  # Indirect associations

  # Validations

end
