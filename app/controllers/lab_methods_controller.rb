class LabMethodsController < ApplicationController

  before_filter :authenticate_user!
#  before_filter :check_permission

  # GET /lab_methods
  # GET /lab_methods.json
  def index
    @lab_methods = LabMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lab_methods }
    end
  end

  # GET /lab_methods/1
  # GET /lab_methods/1.json
  def show
    @lab_method = LabMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab_method }
    end
  end

  # GET /lab_methods/new
  # GET /lab_methods/new.json
  def new
    @lab_method = LabMethod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab_method }
    end
  end

  # GET /lab_methods/1/edit
  def edit
    @lab_method = LabMethod.find(params[:id])
  end

  # POST /lab_methods
  # POST /lab_methods.json
  def create
    @lab_method = LabMethod.new(params[:lab_method])

    respond_to do |format|
      if @lab_method.save
        format.html { redirect_to @lab_method, notice: 'Lab method was successfully created.' }
        format.json { render json: @lab_method, status: :created, location: @lab_method }
      else
        format.html { render action: "new" }
        format.json { render json: @lab_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lab_methods/1
  # PUT /lab_methods/1.json
  def update
    @lab_method = LabMethod.find(params[:id])

    respond_to do |format|
      if @lab_method.update_attributes(params[:lab_method])
        format.html { redirect_to @lab_method, notice: 'Lab method was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lab_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab_methods/1
  # DELETE /lab_methods/1.json
  def destroy
    @lab_method = LabMethod.find(params[:id])
    @lab_method.destroy

    respond_to do |format|
      format.html { redirect_to lab_methods_url }
      format.json { head :no_content }
    end
  end
  
  private

    def check_permission
      if !current_user.administrator?
        flash[:alert] = 'Your account must have the Administrator role to access Lab Methods Manager.';
        redirect_to '/'
      end
    end
    
end
