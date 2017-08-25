class User < ApplicationRecord
  # Direct associations

  has_many   :videos,
             :dependent => :destroy

  has_many   :comments,
             :dependent => :destroy

  has_many   :tags,
             :dependent => :destroy

  # Indirect associations

  # Validations
  validates :username, :presence => true, :uniqueness =>{ :case_sensitive => false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
