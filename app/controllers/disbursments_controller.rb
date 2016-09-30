class DisbursmentsController < ApplicationController
  before_action :set_case #, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /disbursments
  # GET /disbursments.json
  def index
    @disbursments = @case.disbursments
  end

  # GET /disbursments/1
  # GET /disbursments/1.json
  def show
  end

  # GET /disbursments/new
  def new
    @disbursment = Disbursment.new
  end

  # GET /disbursments/1/edit
  def edit
  end

  # POST /disbursments
  # POST /disbursments.json
  def create
    @disbursment = Disbursment.new(disbursment_params)
    @disbursment.case_id = @case.id
    respond_to do |format|
      if @disbursment.save
        format.html { redirect_to case_disbursment_path(@case, @disbursment), notice: 'Disbursment was successfully created.' }
        format.json { render :show, status: :created, location: @disbursment }
      else
        format.html { render :new }
        format.json { render json: @disbursment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disbursments/1
  # PATCH/PUT /disbursments/1.json
  def update
    respond_to do |format|
      if @disbursment.update(disbursment_params)
        format.html { redirect_to case_disbursment_path(@case, @disbursment), notice: 'Disbursment was successfully updated.' }
        format.json { render :show, status: :ok, location: @disbursment }
      else
        format.html { render :edit }
        format.json { render json: @disbursment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disbursments/1
  # DELETE /disbursments/1.json
  def destroy
    @disbursment.destroy
    respond_to do |format|
      format.html { redirect_to case_disbursments_url, notice: 'Disbursment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:case_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disbursment_params
      params.require(:disbursment).permit(:amount, :details, :case_id, :video)
    end
end
