class Issue < ActiveRecord::Base
  belongs_to :service

  SEVERITY = [ 1, 2, 3, 4, 5 ]

  before_validation :reset_time_up_if_not_resoved

  validates :service_id, :presence => true, :reference_service => true   
  validates :title, :presence => true
  validates :severity, :presence => true, :inclusion => SEVERITY

  scope :current_issues, where(:resolved => false).order("time_down desc")
  scope :ordered, order("time_down desc")

  def reset_time_up_if_not_resoved
    self.time_up = nil unless self.resolved
  end
end
