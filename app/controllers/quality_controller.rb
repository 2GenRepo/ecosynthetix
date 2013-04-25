class QualityController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :check_permission

  # GET /qualities
  # GET /qualities.json
  def index
    @sorting = 'DESC'

    if (params[:sortBtn] == 'ASC')
      @sorting = 'ASC'
    else
      @sorting = 'DESC'
    end
    
    @search = Quality.order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").search :lot_or_user_first_name_or_user_last_name_contains => params[:term]    

    if current_user.facility_id == 3
      @qualities = @search.where('facility_origin_id = ?','3').order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
    elsif current_user.facility_id == 2
      @qualities = @search.where('facility_origin_id = ?','2').order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
    else
      @qualities = @search.order("strftime('%Y',date) " + @sorting + ", julian_date DESC, lot DESC, time DESC").page params[:qualities_page]
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qualities }
      format.js
      format.xlsx {
        if !current_user.administrator? and current_user.technician?
          flash[:alert] = 'You do not have the necessary permissions to download this data.'
          redirect_to '/'
        else
          @search = Quality.order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").search :lot_or_user_first_name_or_user_last_name_contains => params[:term]
          if current_user.facility_id == 3
            send_data @search.where('facility_origin_id = ?','3').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'qualitysearch.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
          elsif current_user.facility_id == 2
            send_data @search.where('facility_origin_id = ?','2').order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'qualitysearch.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
          else
            send_data @search.order("strftime('%Y',date) DESC, julian_date DESC, lot DESC, time DESC").to_xlsx.to_stream.read, :filename => 'qualitysearch.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
          end
        end
      }
    end
  end

  # GET /qualities/1
  # GET /qualities/1.json
  def show
    @quality = Quality.find(params[:id])
    quality_history = QualityHistory.new({:user_id => current_user.id, :quality_id => @quality.id, :action_type => 'view'})
    quality_history.save

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quality }
    end
  end

  # GET /qualities/new
  # GET /qualities/new.json
  def new
    @quality = Quality.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quality }
    end
  end

  # GET /qualities/1/edit
  def edit
    @quality = Quality.find(params[:id])
    quality_history = QualityHistory.new({:user_id => current_user.id, :quality_id => @quality.id, :action_type => 'edit'})
    quality_history.save
  end

  # POST /qualities
  # POST /qualities.json
  def create
    @quality = Quality.new(params[:quality].merge(:facility_origin_id => current_user.facility_id))
    respond_to do |format|
      if @quality.save
        
        #QualityMailer.qualityStatus_email(@user).deliver

        format.html { redirect_to @quality, notice: 'Quality was successfully created.' }
        format.json { render json: @quality, status: :created, location: @quality }
      else
        format.html { render action: "new" }
        format.json { render json: @quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qualities/1
  # PUT /qualities/1.json
  def update
    @quality = Quality.find(params[:id])
    respond_to do |format|
      if @quality.update_attributes(params[:quality])

        #QualityMailer.qualityStatus_email(@user).deliver

        format.html { redirect_to @quality, notice: 'Quality was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qualities/1
  # DELETE /qualities/1.json
  def destroy
    @quality = Quality.find(params[:id])
    @quality.destroy

    respond_to do |format|
      format.html { redirect_to qualities_url }
      format.json { head :no_content }
    end
  end
  
  # MODAL /modal
  def modal
    @quality = Quality.new
    @quality.attributes = params[:quality]
    @quality.valid?
    
    respond_to do |format|
      format.html { render action: "modal", :layout => false }
    end
  end      
  
  private

    def check_permission
      if !current_user.quality? && !current_user.technician?
        flash[:alert] = 'Your account must have the Administrator, Quality or Technician role to access Quality Assurance.';
        redirect_to '/'
      end
    end
    
    def corrected_value_for(property_name,property_value_1,property_value_2 = 0)
      case property_name
      when 'bulk_density'
        sprintf("%.1f",property_value_1 / 250 * 62.4279606)
      when 'color'
        if 1.2323 * property_value_1 - 23.052 == -23.052
          0
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
            value = 0
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
             value = 0
           else
             value = 1.2323 * property_value_1 - 23.052
           end
           
           if value == 0
             pass_value
           else
             #################
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
          "&mdash;"
      end
    end

end
