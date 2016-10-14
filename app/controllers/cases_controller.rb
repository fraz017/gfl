class CasesController < ApplicationController
  # before_action :set_case, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 

  # GET /cases
  # GET /cases.json
  def index
    if current_user.admin?
      @cases = Case.pending
      @open_cases = Case.open
      @closed_cases = Case.closed
      @rejected_cases = Case.rejected
    else  
      @cases = current_user.cases
    end  
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @disbursments = @case.disbursments.order(id: :desc)
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(case_params)
    @case.user_id = current_user.id
    respond_to do |format|
      if @case.save
        format.html { redirect_to cases_path, notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to cases_path, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    @case.update(state: :open)
  end

  def reject
    @case.update(state: :rejected)
  end

  def close
    @case.update(state: :closed)
    respond_to do |format|
      format.js { render file: "cases/reject.js.erb"}
    end
  end

  def manager
    @case.update(user_id: params[:user_id])
  end

  def details
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:budget, :name, :state_cd, :user_id, :state, :recieved, :notification_date, :refered_by, :age, :gender, :contact_number, :contact_relation, :contact_name, :address, :address2, :city, :cnic, :problem, :duration, :doctor, :hospital, :doctor_contact, :verification_doc, :benificiary_name,  :benificiary_bank, :bank_address, :account_number, :iban, :swift_code, :verification_method, attachments_attributes: [:id, :file, :_destroy])
    end
end