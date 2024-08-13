class VatCodesController < ApplicationController
  before_action :set_vat_code, only: %i[ show edit update destroy ]

  # GET /vat_codes or /vat_codes.json
  def index
    @vat_codes = VatCode.all
  end

  # GET /vat_codes/1 or /vat_codes/1.json
  def show
  end

  # GET /vat_codes/new
  def new
    @vat_code = VatCode.new
  end

  # GET /vat_codes/1/edit
  def edit
  end

  # POST /vat_codes or /vat_codes.json
  def create
    @vat_code = VatCode.new(vat_code_params)

    respond_to do |format|
      if @vat_code.save
        format.html { redirect_to vat_code_url(@vat_code), notice: "Vat code was successfully created." }
        format.json { render :show, status: :created, location: @vat_code }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vat_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vat_codes/1 or /vat_codes/1.json
  def update
    respond_to do |format|
      if @vat_code.update(vat_code_params)
        format.html { redirect_to vat_code_url(@vat_code), notice: "Vat code was successfully updated." }
        format.json { render :show, status: :ok, location: @vat_code }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vat_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vat_codes/1 or /vat_codes/1.json
  def destroy
    @vat_code.destroy!

    respond_to do |format|
      format.html { redirect_to vat_codes_url, notice: "Vat code was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # poll to perform the job that gets the current set of all vat codes
  def poll
    # VatCodePollJob.perform_later
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vat_code
      @vat_code = VatCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vat_code_params
      params.require(:vat_code).permit(:guid, :gl_to_pay, :description, :code, :account_code, :account)
    end
end
