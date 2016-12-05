class DoctorsController < ApplicationController
  load_and_authorize_resource 

  # GET /users
  # GET /users.json
  def index
    @doctors = Doctor.where(role_cd: 2)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @doctor = Doctor.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @doctor = Doctor.new(user_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @doctor.update(user_params)
        format.html { redirect_to @doctor, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @doctor = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:doctor].delete(:password) if params[:doctor][:password].blank?
      params[:doctor].delete(:password_confirmation) if params[:doctor][:password].blank? and params[:doctor][:password_confirmation].blank?

      params.require(:doctor).permit(:email, :first_name, :last_name, :mobile_number, :role, :role_cd, :password)
    end
end
