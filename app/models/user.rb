class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :facility_id, :administrator, :technician, :labSupervisor, :sales, :customer, :quality, :active, :select_display
  
  # Validation
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :facility_id, :presence => true
  validate :role_checked
  #validates :role_checked
  #validates :email, :uniqueness => true
  
  # Association
  belongs_to :facility
  has_many :quality_histories
  has_many :qualities
  
  # Callbacks
  before_create do |user|
    user.active = 1
  end
  
  private
  
    # Validator
    def role_checked
      if !self.sales && !self.administrator && !self.quality && !self.customer && !self.technician && !self.labSupervisor
        self.errors[:base] << "You must select at least 1 role."
      end
    end
  
end
