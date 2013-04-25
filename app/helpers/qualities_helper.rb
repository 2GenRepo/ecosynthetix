module QualitiesHelper

  def corrected_value_for(property_name,property_value_1,property_value_2 = 0)
    case property_name
    when 'bulk_density'
      sprintf("%.1f",property_value_1 / 250 * 62.4279606)
    when 'color'
      if 1.2323 * property_value_1 - 23.052 == -23.052
        "N/A"
      else
        (1.2323 * property_value_1 - 23.052).ceil
      end
    when 'moisture'
      sprintf("%.1f",property_value_1)
    when 'viscosity'
      if ((0.257 * property_value_1 - 1.2482) * (17.5 - property_value_2) + property_value_1) == -21.8435
        "0"
      else
        sprintf("%.1f",(0.257 * property_value_1 - 1.2482) * (17.5 - property_value_2) + property_value_1)
      end
    end
  end
  
  def pass_or_fail_for(property_name,property_value_1,property_value_2 = 0,property_value_3 = 0,property_value_4 = 0,format = 0)
    case format
      when 0
        pass_value = "<div class=""pass"">PASS</div>"
        fail_value = "<div class=""fail"">FAIL</div>"
      when 1
        pass_value = "pass"
        fail_value = "fail"
    end
    
    case property_name
      when 'viscosity'
        corrected_viscosity = corrected_value_for('viscosity',property_value_1,property_value_2).to_i
        if ((0.0029 * (corrected_viscosity) ** 3 - 0.1753 * (corrected_viscosity) ** 2 + 8.5102 * (corrected_viscosity)) == 0)
          value = "N/A"
        else 
          value = 0.0029 * (corrected_viscosity) ** 3 - 0.1753 * (corrected_viscosity) ** 2 + 8.5102 * (corrected_viscosity)
        end
        
        if value >= 100
          if value <= 300
            raw pass_value
          else
            raw fail_value
          end
        else
          raw fail_value
        end
      when 'color'
         if 1.2323 * property_value_1 - 23.052 == -23.052
           value = "N/A"
         else
           value = 1.2323 * property_value_1 - 23.052
         end
         
         if value == 0
           raw pass_value
         else
           if value >= 20
             if value <= 70
               raw pass_value
             else
               raw fail_value
             end
           else
             raw fail_value
           end
         end
      when 'moisture'
        value = sprintf("%.1f",property_value_1).to_i
        if value == 0
          raw pass_value
        else
          if value >= 6.0
            if value <= 10.5
              raw pass_value
            else
              raw fail_value
            end
          else
            raw fail_value
          end
        end
      when 'bulk_density'
        value = corrected_value_for('bulk_density',property_value_1).to_i
        if value == 0
          "N/A"
        else
          if value >= 32
            if value <= 42
              raw pass_value
            else
              raw fail_value
            end
          else
            raw fail_value
          end
        end
      when 'disposition'
        solids = property_value_1
        viscosity = property_value_2
        color = property_value_3
        moisture = property_value_4
        viscosity_status = pass_or_fail_for('viscosity',viscosity,solids,0,0,format)
        color_status = pass_or_fail_for('color',color,0,0,0,format)
        moisture_status = pass_or_fail_for('moisture',moisture,0,0,0,format)
        if solids >= 16.5 && solids <= 18.5
          if viscosity_status == pass_value
            if color_status == pass_value
              if moisture_status == pass_value
                raw pass_value
              else
                raw fail_value
              end
            else 
              raw fail_value
            end
          else
            raw fail_value
          end
        else
          raw fail_value
        end
      else
        raw "&mdash;"
    end
  end

end
