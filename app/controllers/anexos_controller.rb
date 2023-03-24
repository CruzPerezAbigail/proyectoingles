
class AnexosController < ApplicationController
  before_action :set_anexo, only: %i[ show edit update destroy ]

  # GET /anexos or /anexos.json
  def index
    @anexos = Anexo.all
  end

  # GET /anexos/1 or /anexos/1.json
  def show
  end

  # GET /anexos/new
  def new
    @anexo = Anexo.new
  end

  # GET /anexos/1/edit
  def edit
  end

  # POST /anexos or /anexos.json
  def create
    @anexo = Anexo.new(anexo_params)

    respond_to do |format|
      if @anexo.save
        blob = @anexo.uploads.first.blob
        #blob = @documento.archivo_pdf.first.blob
        updated_at = File.mtime(blob.service.path_for(blob.key)).strftime('%Y-%m-%d %H:%M:%S')

        # Se asume que el archivo subido se ha adjuntado a un objeto ActiveStorage::Blob y se ha recuperado en la variable 'blob'
        
        # Leer el contenido del archivo PDF
        pdf_content = blob.download
        
        format.html { redirect_to anexo_url(@anexo), notice: "Anexo was successfully created." }
        format.json { render :show, status: :created, location: @anexo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @anexo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anexos/1 or /anexos/1.json
  def update
    respond_to do |format|
      if @anexo.update(anexo_params)
        format.html { redirect_to anexo_url(@anexo), notice: "Anexo was successfully updated." }
        format.json { render :show, status: :ok, location: @anexo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @anexo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anexos/1 or /anexos/1.json
  def destroy
    @anexo.destroy

    respond_to do |format|
      format.html { redirect_to anexos_url, notice: "Anexo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anexo
      @anexo = Anexo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def anexo_params
      params.require(:anexo).permit(:titulo, uploads: [])
    end
end
