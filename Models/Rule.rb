class Rule < ActiveRecord::Base
  
  
  def self.getLatestRule
    Rule.order(updated_at: :desc).first(1)
  end
end