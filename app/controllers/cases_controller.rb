class CasesController < ApplicationController
  # before_action :set_case, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:autocomplete_problem_name, :autocomplete_treatment_name]

  autocomplete :problem, :name
  autocomplete :treatment, :name

  # GET /cases
  # GET /cases.json
  def index
    if current_user.admin?
      @cases = Case.pending.rank(:row_order)
      @open_cases = Case.open.rank(:row_order)
      @closed_cases = Case.closed.rank(:row_order)
      @rejected_cases = Case.rejected.rank(:row_order)
      @archived_cases = Case.where(deleted: true).rank(:row_order)
    else  
      @cases = current_user.cases.where(deleted: false)
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
    @case.update_columns(deleted: true)
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def unarchive
    @case.update_columns(deleted: false)
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
    @comment = Comment.new
  end

  def update_row_order
    @case = Case.find(case_params[:case_id])
    @case.row_order_position = case_params[:row_order_position]
    @case.save(:validate => false)

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def autocomplete_problem_name
    problems = Problem.search_by_name(params[:term])
    data = Array.new
    problems = problems.each do |z| 
      h = Hash.new
      h["value"] = "#{z.name}"
      h["label"] = "#{z.name}"
      h["problem"] = "#{z.name}"
      data.push(h)
    end
    render :json => data
  end

  def autocomplete_treatment_name
    treatments = Treatment.search_by_name(params[:term])
    data = Array.new
    treatments = treatments.each do |z| 
      h = Hash.new
      h["value"] = "#{z.name}"
      h["label"] = z.problem.present? ? "#{z.name} for #{z.problem.name}" : "#{z.name}"
      h["treatment"] = "#{z.name}"
      data.push(h)
    end
    render :json => data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:budget, :name, :state_cd, :user_id, :state, :recieved, :notification_date, :refered_by, :age, :gender, :contact_number, :contact_relation, :contact_name, :address, :address2, :city, :cnic, :problem, :treatment, :duration, :doctor, :hospital, :doctor_contact, :verification_doc, :benificiary_name,  :benificiary_bank, :bank_address, :account_number, :iban, :swift_code, :verification_method, :case_id, :row_order_position, attachments_attributes: [:id, :file, :_destroy])
    end
end