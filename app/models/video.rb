class Video < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :videolink, :presence => { :message => "Please enter a video link" }

end
