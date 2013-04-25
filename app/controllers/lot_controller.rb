class LotController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_permission

  def certificate
    if current_user.facility_id == 3
      @lots = Quality.where('facility_origin_id = ?','3').lots.all.map { |l| [l.lot, l.lot] }
    elsif current_user.facility_id == 2
      @lots = Quality.where('facility_origin_id = ?','2').lots.all.map { |l| [l.lot, l.lot] }
    else
      @lots = Quality.lots.all.map { |l| [l.lot, l.lot] }
    end
    @certificate = Certificate.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def certificate_review
    @qualities = Quality.find(params[:quality_to_include].split(','))
    
    respond_to do |format|
      format.html { render action: "certificate_review", :layout => false }
    end
  end
  
  def certificate_print
    @qualities = Quality.find(params[:certificate][:quality_selected].split(','))
    @quality_lots = Quality.group('lot').find_all_by_id(params[:certificate][:quality_selected].split(','))
    @quality_lots_list = @quality_lots.map(&:lot)
    @certificate = Certificate.new(params[:certificate])
    @average_moisture = Quality.where('id IN (?)',@qualities).average(:last_moisture_value)
    @average_viscosity = Quality.where('id IN (?)',@qualities).average(:last_viscosity_value)
    @average_color_l = Quality.where('id IN (?)',@qualities).average(:last_color_l_value)
    @product = Product.find(@qualities[0].product_id)

    Quality.update_all('coa_printed = "true"', 'id IN (' + params[:certificate][:quality_selected] + ')')

    respond_to do |format|
      format.html { render action: "certificate_print", :layout => 'blank' }
    end
  end
  
  def certificate_generate
    @certificate = Certificate.new
    
    respond_to do |format|
      format.html { render action: "certificate_generate", :layout => false }
    end
  end
  
  private

    def check_permission #checks permissions for the reporting section
      if current_user.labSupervisor?
        #allow past
      elsif !current_user.administrator?
        flash[:alert] = 'Your account must have the Administrator roles to access Certificate functionality.';
        redirect_to '/'
      end
    end
    
  
end