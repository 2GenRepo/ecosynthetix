class Quality < ActiveRecord::Base
  acts_as_xlsx

  # Attributes
  attr_accessor :full_lot
  
  # Association
  belongs_to :user 
  belongs_to :lab_method
  belongs_to :product
  
  # Callbacks
  after_validation :calculate_values
  
  # Validation
  validates :product_id, :presence => true
  validates :date, :presence => true
  validates :lot, :presence => true
  validates_format_of :lot, :with => /^[A-Z]{2}[0-9]{3}[0-9]{2}[A-Z]{1}$/
  validates :julian_date, :presence => true
  validates_format_of :julian_date, :with => /^\d{3}$/
  validates :time, :presence => true
  validates :tank, :presence => true, :unless => "skid.present?"
  validates :tank, :numericality => { :greater_than_or_equal_to => 0 }, :unless => "tank.blank?"
  validates :skid, :presence => true, :unless => "tank.present?"
  validates :skid, :numericality => { :greater_than_or_equal_to => 0 }, :unless => "skid.blank?"
  validates_length_of :skid, :minimum => 3, :maximum => 3, :allow_blank => true
  validates_length_of :tank, :minimum => 3, :maximum => 3, :allow_blank => true
  validates :viscosity, :presence => true
  validates :viscosity, :numericality => { :greater_than_or_equal_to => 0 }
  validates_format_of :viscosity, :with => /^\d+\.*\d{0,5}$/
  validates :lab_method_id, :presence => true
  validates_format_of :color_l, :with => /^\d+\.*\d{0,5}$/
  validates :color_l, :numericality => { :greater_than_or_equal_to => 0 }
  validates_format_of :color_a, :with => /^\d+\.*\d{0,5}$/
  validates :color_a, :numericality => { :greater_than_or_equal_to => 0 }
  validates_format_of :color_b, :with => /^\d+\.*\d{0,5}$/
  validates :color_b, :numericality => { :greater_than_or_equal_to => 0 }
  validates :starch_lot, :presence => true
  validates :date, :presence => true
  validate :solid_validation
  validate :temp_validation
  validate :check_skid_tank
  
  # Conditional Validation
  validates_format_of :temperature, :with => /^\d+\.*\d{0,5}$/, :if => lambda {
    if self.lab_method_id
      lab_method = LabMethod.find(self.lab_method_id)
      lab_method.temperature?
    end
  }  
  validates_format_of :solids, :with => /^\d+\.*\d{0,5}$/, :if => lambda {
    if self.lab_method_id
      lab_method = LabMethod.find(self.lab_method_id)
      lab_method.solids?
    end
  }
  validates_format_of :moisture, :with => /^\d+\.*\d{0,5}$/, :if => lambda {
    if self.lab_method_id
      lab_method = LabMethod.find(self.lab_method_id)
      lab_method.moisture?
    end
  }
  validates :moisture, :numericality => { :greater_than_or_equal_to => 0 }, :if => lambda { 
    if self.lab_method_id
      lab_method = LabMethod.find(self.lab_method_id)
      lab_method.moisture?
    end
  }
  validates :bulk_density, :numericality => { :greater_than_or_equal_to => 0 }, :if => lambda { 
    if self.lab_method_id
      lab_method = LabMethod.find(self.lab_method_id)
      lab_method.bulk_density?
    end
  }

def solid_validation
  if self.lab_method_id  
    if (val = Kernel.Float(solids) rescue nil)
      if self.lab_method_id == 1
        val = Kernel.Float(solids)
        min = 24
        max = 28
        errors.add(:solids, "must be greater than or equal to #{min}%, please redisperse and retest") if val < min
        errors.add(:solids, "must be less than or equal to #{max}%, please redisperse and retest") if val > max
      elsif self.lab_method_id == 2
        val = Kernel.Float(solids)
        min = 16.5
        max = 18.5
        errors.add(:solids, "must be greater than or equal to #{min}%, please redisperse and retest") if val < min
        errors.add(:solids, "must be less than or equal to #{max}%, please redisperse and retest") if val > max
      end
    else
      errors.add(:solids, :not_a_number) 
    end
  end
end

def temp_validation
  if self.lab_method_id  
    if (val = Kernel.Float(temperature) rescue nil)
      if self.lab_method_id == 1
        val = Kernel.Float(temperature)
        min = 20
        max = 29
        errors.add(:temperature, "must be greater than or equal to #{min} degrees celcius") if val < min
        errors.add(:temperature, "must be less than or equal to #{max} degrees celcius") if val > max
      end
    else
      if self.lab_method_id == 1
        errors.add(:temperature, :not_a_number) 
      else
        #donothing
      end
    end
  end
end

def check_skid_tank
  if !skid.blank? && !tank.blank?
    errors.add(:tank, "and Skid cannot be filled in at the same time") 
  end
end

  
  # Validation Helpers
  def correct_lab_method(field)
    field == 'temperature'
  end
  
  def full_lot
    begin
      quality_time = self.time
    rescue
      quality_time = Date.parse(self.time)
    end
    self.lot.to_s + self.julian_date.to_s + quality_time.strftime("%H%M").to_s + self.tank.to_s + self.skid.to_s
  end


  
  # Scopes
  scope :lots, lambda {
    group('lot')
  }
  
  scope :lot, lambda { |id| 
    where('lot = ?',id)
  }
  
  private 
    
    def calculate_values
      case self.lab_method_id
        # CAP2000+
        when 2
          # Bulk Density
          if self.bulk_density
            self.last_bulk_density_value = sprintf("%.2f",self.bulk_density / 250 * 62.4279606)
            self.last_bulk_density_state = "fail"
            if self.last_bulk_density_value >= 34 && self.last_bulk_density_value <= 42 
              self.last_bulk_density_state = "pass"
            end
          end
          # Moisture
          if self.moisture
            self.last_moisture_value = sprintf("%.2f",self.moisture)
            self.last_moisture_state = "fail"
            if (self.last_moisture_value == 0) || (self.last_moisture_value >= 4.0 && self.last_moisture_value <= 8.0)
              self.last_moisture_state = "pass"
            end 
          end
          # Color L
          if self.color_l
            self.last_color_l_state = "fail"

            if self.product_id == 1

              self.last_color_l_value = sprintf("%.2f",1.2323 * self.color_l - 23.052)
              if self.last_color_l_value == -23.052
                self.last_color_l_value = 0
              end

              if (self.last_color_l_value == 0) || (self.last_color_l_value >= 30.0 && self.last_color_l_value <= 70.0) 
                self.last_color_l_state = "pass"
              end

            elsif self.product_id == 2

              self.last_color_l_value = sprintf("%.2f",1.0223 * self.color_l - 1.9491)
              if self.last_color_l_value == -1.9491
                self.last_color_l_value = 0
              end

              if (self.last_color_l_value == 0) || (self.last_color_l_value >= 60.0 && self.last_color_l_value <= 80.0) 
                self.last_color_l_state = "pass"
              end
              
            end
          end
          # Viscosity
          if self.viscosity && self.solids
            self.last_corrected_viscosity_value = ((0.257 * self.viscosity - 1.2482) * (17.5 - self.solids) + self.viscosity)
            if self.last_corrected_viscosity_value == -21.8435
              self.last_corrected_viscosity_value = 0
            end

            if self.product_id == 1
              self.last_viscosity_value = sprintf("%.2f",(0.0029 * (self.last_corrected_viscosity_value) ** 3 - 0.1753 * (self.last_corrected_viscosity_value) ** 2 + 8.5102 * (self.last_corrected_viscosity_value)))
              self.last_viscosity_state = "fail"
            elsif self.product_id == 2
              self.last_viscosity_value = sprintf("%.2f",(0.0025 * (self.last_corrected_viscosity_value) ** 3 - 0.1859 * (self.last_corrected_viscosity_value) ** 2 + 9.1022 * (self.last_corrected_viscosity_value)))
              self.last_viscosity_state = "fail"
            end

            if self.last_viscosity_value >= 100 && self.last_viscosity_value <= 250
              self.last_viscosity_state = "pass"
            end
          end
          # Disposition
          if self.last_viscosity_state && self.last_color_l_state && self.last_moisture_state && self.solids
            self.last_disposition_state = "fail"
            if (self.solids >= 16.5 && self.solids <= 18.5) && self.last_viscosity_state == "pass" && self.last_color_l_state == "pass" && self.last_moisture_state == "pass"
              self.last_disposition_state = "pass"  
            end
          end
          
        # DV II Pro
        when 1
          # Bulk Density
          if self.bulk_density
            self.last_bulk_density_value = sprintf("%.2f",self.bulk_density / 250 * 62.4279606)
            self.last_bulk_density_state = "fail"
            if self.last_bulk_density_value >= 32 && self.last_bulk_density_value <= 42 
              self.last_bulk_density_state = "pass"
            end
          end
          # Moisture
          if self.moisture
            self.last_moisture_value = sprintf("%.1f",self.moisture)
            self.last_moisture_state = "fail"
            if (self.last_moisture_value == 0) || (self.last_moisture_value >= 4.5 && self.last_moisture_value <= 8.0)
              self.last_moisture_state = "pass"
            end 
          end
          # Color L
          if self.color_l
            self.last_color_l_value = self.color_l
            self.last_color_l_state = "fail"
            if self.product_id == 1
              if (self.last_color_l_value == 0) || (self.last_color_l_value >= 30.0 && self.last_color_l_value <= 70.0) 
                self.last_color_l_state = "pass"
              end
            elsif self.product_id == 2
              if (self.last_color_l_value == 0) || (self.last_color_l_value >= 60.0 && self.last_color_l_value <= 80.0) 
                self.last_color_l_state = "pass"
              end
            end
          else
            self.last_color_l_value = 0
          end
          # Viscosity


          if self.temperature && self.viscosity
            self.last_corrected_viscosity_value = (self.viscosity * 2 ** (-0.0323 * (25 - self.temperature)) + 0.1013 * (25 - self.solids) ** 3 - 2.5908 * (25 - self.solids) ** 2 + 27.982 * (25 - self.solids))
            if self.last_corrected_viscosity_value == 663.1125
              self.last_corrected_viscosity_value = 0
            end
          else
            self.last_corrected_viscosity_value = 0
          end
          self.last_viscosity_value = sprintf("%.2f",self.last_corrected_viscosity_value)
          self.last_viscosity_state = "fail"
          if self.last_viscosity_value >= 100 && self.last_viscosity_value <= 250
            self.last_viscosity_state = "pass"
          end
          # Disposition
          self.last_disposition_state = "fail"
          if self.last_viscosity_state == "pass" && self.last_color_l_state == "pass" && self.last_moisture_state == "pass"
            self.last_disposition_state = "pass"  
          end
          
      end  

    end

end
