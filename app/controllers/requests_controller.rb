class RequestsController < ApplicationController
  # before_action :set_requests
  # before_action :set_request, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :case
  load_and_authorize_resource :request, :through => :case

  # GET cases/1/requests
  def index
    @requests = @case.requests
  end

  # GET cases/1/requests/1
  def show
  end

  # GET cases/1/requests/new
  def new
    @request = @case.requests.build
  end

  # GET cases/1/requests/1/edit
  def edit
  end

  # POST cases/1/requests
  def create
    @request = @case.requests.build(request_params)

    if @request.save
      redirect_to([@request.case, @request], notice: 'Request was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT cases/1/requests/1
  def update
    if @request.update_attributes(request_params)
      redirect_to([@request.case, @request], notice: 'Request was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE cases/1/requests/1
  def destroy
    @request.destroy

    redirect_to case_requests_url(@case)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requests
      @case = Case.find(params[:case_id])
    end

    def set_request
      @request = @case.requests.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def request_params
      params.require(:request).permit(:content)
    end
end
