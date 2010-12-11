class Issue < ActiveRecord::Base
  belongs_to :service

  validates :service_id, :presence => true, :reference_service => true   
  validates :title, :presence => true
  validates :severity, :presence => true, :inclusion => [1, 2, 3, 4, 5]

  def self.current_issues
    self.where(:resolved => false)
  end
end