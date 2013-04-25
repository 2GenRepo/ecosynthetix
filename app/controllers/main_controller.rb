class MainController < ApplicationController

  before_filter :authenticate_user!
  
  def dashboard
    @search = Quality.search(params[:search])
    @qualities = @search.page params[:page]
    
    if current_user.facility_id == 3
      @qualities_failed = Quality.where('last_disposition_state = ?','fail').where('facility_origin_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).search(params[:search])
      @qualities_passed = Quality.where('last_disposition_state = ?','pass').where('facility_origin_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).search(params[:search])
    elsif current_user.facility_id == 2
      @qualities_failed = Quality.where('last_disposition_state = ?','fail').where('facility_origin_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).search(params[:search])
      @qualities_passed = Quality.where('last_disposition_state = ?','pass').where('facility_origin_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).search(params[:search])
    else
      @qualities_failed = Quality.where('last_disposition_state = ?','fail').limit(10).search(params[:search])
      @qualities_passed = Quality.where('last_disposition_state = ?','pass').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).search(params[:search])
    end

    

    respond_to do |format|
      format.html
      format.js
      format.xlsx {

        if !current_user.administrator? and current_user.technician?
          flash[:alert] = 'You do not have the necessary permissions to download this data.'
          redirect_to '/'
        else
          if(params[:passed] == 'true')
            if current_user.facility_id == 3
              send_data Quality.where('last_disposition_state = ?','pass').where('facility_origin_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'passed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            elsif current_user.facility_id == 2
              send_data Quality.where('last_disposition_state = ?','pass').where('facility_origin_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'passed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            else
              send_data Quality.where('last_disposition_state = ?','pass').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'passed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            end
          elsif(params[:passed] == "false")
            if current_user.facility_id == 3
              send_data Quality.where('last_disposition_state = ?','fail').where('facility_origin_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'failed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            elsif current_user.facility_id == 2
              send_data Quality.where('last_disposition_state = ?','fail').where('facility_origin_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'failed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            else
              send_data Quality.where('last_disposition_state = ?','fail').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").limit(10).to_xlsx.to_stream.read, :filename => 'failed.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
            end
          else
            #do nothing
          end
        end
      }
    end
  end

  def reporting
  end
  
  def settings
    check_permission
  end
  
  def options
    check_permission
    
    if(params.has_key?('commit')) 
      if(params[:commit] == 'Revalidate data' || params[:commit] == 'Please wait...') 
        Quality.all.each do |quality| 
          if quality.valid? 
            quality.save!
          else 
            #dot nothing
          end
        end

        respond_to do |format|
          format.js
        end
      end
    end
  end
  
  #search for dashboard. queried when search button clicked
  def search
    @sorting = 'DESC'

    if (params[:sortBtn] == 'ASC')
      @sorting = 'ASC'
    else
      @sorting = 'DESC'
    end
    
    @qualities_search = Quality.order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").search :lot_or_user_first_name_or_user_last_name_contains => params[:term]
    @users_search = User.order("last_name ASC").search :first_name_or_last_name_or_email_contains => params[:term]
    
    if current_user.facility_id == 3
      @qualities = @qualities_search.where('facility_origin_id = ?','3').order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
      @users = @users_search.where('facility_id = ?','3').order("last_name ASC").page params[:users_page]
    elsif current_user.facility_id == 2
      @qualities = @qualities_search.where('facility_origin_id = ?','2').order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
      @users = @users_search.where('facility_id = ?','2').order("last_name ASC").page params[:users_page]
    else
      @qualities = @qualities_search.order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
      @users = @users_search.order("last_name ASC").page params[:users_page]
    end

    respond_to do |format|
      format.html
      format.js
      format.xlsx {
        if !current_user.administrator? and current_user.technician?
          flash[:alert] = 'You do not have the necessary permissions to download this data.'
          redirect_to '/'
        else
          if(params[:searchType] == 'qualities')
            @qualities_search = Quality.order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").search :lot_or_user_first_name_or_user_last_name_contains => params[:term]
            if current_user.facility_id == 3
              send_data @qualities_search.where('facility_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'search.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet" 
            elsif current_user.facility_id == 2
              send_data @qualities_search.where('facility_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'search.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"  
            else
              send_data @qualities_search.order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'search.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet" 
            end     
          elsif(params[:passed] == "users")
            #do nothing
          else
            #do nothing
          end
        end
      }
    end
  end

  private

    def check_permission
      if !current_user.administrator?
        flash[:alert] = 'Your account must have the Administrator role to access Application Settings.'
        redirect_to '/'
      end
    end
    
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
    
    def pass_or_fail_for_disposition(quality)
      pass_or_fail_for('disposition',quality.solids,quality.viscosity,quality.color_l,quality.moisture,0).to_s == "pass"
    end
    
    def pass_or_fail_for(property_name,property_value_1,property_value_2 = 0,property_value_3 = 0,property_value_4 = 0,format = 0)
      pass_value = "pass"
      fail_value = "fail"
      
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
              pass_value
            else
              fail_value
            end
          else
            fail_value
          end
        when 'color'
           if 1.2323 * property_value_1 - 23.052 == -23.052
             value = "N/A"
           else
             value = 1.2323 * property_value_1 - 23.052
           end
           
           if value == 0
             pass_value
           else
             if value >= 20
               if value <= 70
                 pass_value
               else
                 fail_value
               end
             else
               fail_value
             end
           end
        when 'moisture'
          value = sprintf("%.1f",property_value_1).to_i
          if value == 0
            pass_value
          else
            if value >= 6.0
              if value <= 10.5
                pass_value
              else
                fail_value
              end
            else
              fail_value
            end
          end
        when 'bulk_density'
          value = corrected_value_for('bulk_density',property_value_1).to_i
          if value == 0
            "N/A"
          else
            if value >= 32
              if value <= 42
                pass_value
              else
                fail_value
              end
            else
              fail_value
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
                  pass_value
                else
                  fail_value
                end
              else 
                fail_value
              end
            else
              fail_value
            end
          else
            fail_value
          end
        else
          fail_value
      end
    end
  
end
