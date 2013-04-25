class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_permission, :except => [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @search = User.search(params[:search])
    @users = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.active = 1;

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.id.to_s == params[:id] || current_user.administrator?
      @user = User.find(params[:id])
    else
      check_permission
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/users', notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if current_user.administrator?
          format.html { redirect_to '/users', notice: 'User was successfully updated.' }
        else
          format.html { redirect_to '/dashboard', notice: 'Your account has been updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def me
    @user = User.find(current_user.id)
    
    respond_to do |format|
      format.html { render action: "edit" }
      format.json { render json: @user }
    end
  end
  
  private

    def check_permission
      if !current_user.administrator?
        flash[:alert] = 'Your account must have the Administrator role to access User Manager.';
        redirect_to '/'
      end
    end
    
end
