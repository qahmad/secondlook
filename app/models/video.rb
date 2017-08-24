class Video < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :videolink, :uniqueness => { :scope => [:starttime, :user_id], :message => "You have already linked this video at this start time! Please add a different video or enter a different start time." }

  validates :videolink, :presence => { :message => "Please enter a video link" }

end
