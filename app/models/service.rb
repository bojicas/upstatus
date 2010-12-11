class Service < ActiveRecord::Base
  has_many :issues, :dependent => :destroy

  validates :title, :presence => true, :uniqueness => true
end
