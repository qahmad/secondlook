class Video < ApplicationRecord
  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :tags,
             :dependent => :destroy

  # Indirect associations

  # Validations

  validates :starttime, :uniqueness => { :scope => [:videolink, :user_id], :message => "You have already linked this video at this start time! Please add a different video or enter a different start time." }

  validates :starttime, :presence => true

  validates :starttime, :numericality => { :greater_than => 1 }

  validates :videolink, :uniqueness => { :scope => [:starttime, :user_id], :message => "You have already linked this video at this start time! Please add a different video or enter a different start time." }

  validates :videolink, :presence => { :message => "Please enter a video link" }

end
