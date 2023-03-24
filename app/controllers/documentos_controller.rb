require 'nokogiri'
require 'builder'
require 'pdf-reader'
class DocumentosController < ApplicationController
  before_action :set_documento, only: %i[ show edit update destroy ]

  # GET /documentos or /documentos.json
  def index
    @documentos= Documento.all
    #ActiveStorage::Blob.all
    #@documentos = Documento.joins(:user).where(estatus: "pagado", users: { role: "direccion" })
  end

  # GET /documentos/1 or /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @documento = Documento.new
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos or /documentos.json
  def download_pdf
    port_str = "/dev/ttyUSB0"  # Ruta del puerto serial
baud_rate = 9600           # Velocidad de transmisión en baudios
data_bits = 8              # Bits de datos
stop_bits = 1              # Bits de parada
parity = SerialPort::NONE  # Paridad

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

while true do
  data = sp.gets.chomp  # Lee una línea desde el puerto serial
   # Recupere el código de barras del parámetro de la solicitud
   barcode = params[:serial]
    
   # Busque el registro correspondiente en la tabla "active_store_blobs"
   blob = ActiveStoreBlob.find_by(barcode: barcode)
   
   # Recupere el contenido del archivo PDF desde la columna "data" de la tabla "active_store_blobs"
   pdf_content = blob.data
   
   # Envíe el archivo PDF al navegador como respuesta HTTP
   send_data pdf_content, type: 'application/pdf'
  puts "Dato recibido: #{data}"

sp.close
 
  end
end 



  def create
    @documento = Documento.new(documento_params)
  
    respond_to do |format|
      if @documento.save
        # Obtenemos el objeto ActiveStorage::Blob asociado al archivo subido
        blob = @documento.uploads.first.blob
        #blob = @documento.archivo_pdf.first.blob
        updated_at = File.mtime(blob.service.path_for(blob.key)).strftime('%Y-%m-%d %H:%M:%S')

        # Se asume que el archivo subido se ha adjuntado a un objeto ActiveStorage::Blob y se ha recuperado en la variable 'blob'
        
        # Leer el contenido del archivo PDF
        pdf_content = blob.download
        
        
        
       
        
       


  
        format.html { redirect_to documento_url(@documento), notice: "Documento was successfully created." }
        format.json { render :show, status: :created, location: @documento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end
  # def create
  #   @documento = Documento.new(documento_params)
  
  #   respond_to do |format|
  #     if @documento.save
  #       # Crear archivo XML
  #       xml = Builder::XmlMarkup.new(indent: 2)
  #       xml.instruct!(:xml, version: "1.0", encoding: "UTF-8")
  #       xml.documento do
  #         xml.oficio @documento.oficio
  #         xml.asunto @documento.asunto
  #         xml.fecha @documento.fecha
  #         xml.planestudos @documento.planestudos
  #         xml.seccion @documento.seccion
  #         xml.numerocontrol @documento.numerocontrol
  #         xml.nombre @documento.nombre
  #         xml.uploads do
  #           @documento.uploads.each do |upload|
  #             xml.upload do
  #               xml.filename upload.filename.to_s
  #               xml.content_type upload.content_type
  #               xml.byte_size upload.byte_size
  #               xml.created_at upload.created_at
  #             end
  #           end
  #         end
  #       end
  
  #       # Guardar archivo XML
  #       File.open('archivo.xml', 'w') { |file| file.write(xml.target!) }
  
  #       format.html { redirect_to documento_url(@documento), notice: "Documento was successfully created." }
  #       format.json { render :show, status: :created, location: @documento }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @documento.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
    


  # PATCH/PUT /documentos/1 or /documentos/1.json
  def update
    respond_to do |format|
      if @documento.update(documento_params)
        format.html { redirect_to documento_url(@documento), notice: "Documento was successfully updated." }
        format.json { render :show, status: :ok, location: @documento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1 or /documentos/1.json
  def destroy
    @documento.destroy

    respond_to do |format|
      format.html { redirect_to documentos_url, notice: "Documento was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @documento = Documento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def documento_params
      params.require(:documento).permit(:oficio, :asunto, :fecha, :planestudos, :seccion, :numero_de_control, :nombre,:status, :archivo_pdf, uploads: [])
    end
end 