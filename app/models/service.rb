class Service < ActiveRecord::Base
  has_many :issues

  validates :title, :presence => true, :uniqueness => true
end
