class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @documento = Documento.find(params[:documento_id])
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    
    @payment = Payment.new(payment_params)
    @payment.documento_id = params[:payment][:documento_id]

    logger.debug("Documento ID: #{params[:payment][:documento_id]}")

    if @payment.save
      redirect_to payment_path(@payment), notice: "El pago ha sido agregado con éxito."
      #redirect_to document_path(@payment.documento), notice: "El pago ha sido agregado con éxito."
    else
      render :new
    end

    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
    #     format.json { render :show, status: :created, location: @payment }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:numero_control, :status, :documento_id, uploads: [])
    end
end
