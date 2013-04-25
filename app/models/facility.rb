class Facility < ActiveRecord::Base
  has_many :users 

  # Methods
  def select_display
    display_name + ' (' + city + ')'
  end
  
end
