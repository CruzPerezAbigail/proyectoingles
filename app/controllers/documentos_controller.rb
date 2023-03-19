require 'nokogiri'
require 'builder'
require 'pdf-reader'
class DocumentosController < ApplicationController
  before_action :set_documento, only: %i[ show edit update destroy ]

  # GET /documentos or /documentos.json
  def index
    @documentos= Documento.where(estatus :"pagado")
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
        
        # Crear un objeto PDF::Reader
        pdf_reader = PDF::Reader.new(StringIO.new(pdf_content))
        
        # Obtener el contenido de cada página del PDF
        page_contents = pdf_reader.pages.map { |page| page.text }
        
        # Buscar y extraer los datos específicos de la página
        asunto = ""
        plan=""
        nombre = ""
        numero_de_control = ""
        carrera = ""
        nivel=""
        periodo=""
        fecha=""
        cadena_comprobacion=""
        page_contents.each do |content|
          if content.include?("ASUNTO:")
            asunto = content[/ASUNTO:\s*(.*)/, 1].strip
          end

          if content.include?("con registro vigente")
            plan = content[/vigente\s*(.?)\s,/, 1]
          end
         

          if content.include?("C.")
            nombre= content[/C\.\s*([^,]*)/, 1].strip
            
          end
         
          if content.include?("control")
            numero_de_control= content[/control\s*(.?)\s,/, 1]
            
          end
         


          if content.include?("de la carrera")
            carrera = content[/carrera\s*(.?)\s,/, 1]
            
          end

          if content.include?("nivel de")
            nivel= content[/(?<=nivel de\s)[^\s]+/]
          end
         
        
          if content.include?("periodo")
            periodo = content[/periodo\s*(.*)/, 1].strip
          
          end

          if content.include?("el día")
            fecha = content[/día\s*([^.]*)/, 1].strip
          end          

          if content.include?("CADENA DE COMPROBACIÓN:")
            cadena_comprobacion = content[/COMPROBACIÓN:\s*(.*)/, 1].strip
          end
        end
        
        # Crear un documento XML con Nokogiri
        
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.file {
            xml.filename blob.filename
            xml.size blob.byte_size
            xml.content_type blob.content_type
            xml.created_at blob.created_at
            xml.updated_at updated_at
            xml.metadata {
              xml.variant asunto
            }
            xml.datos {
              xml.plan plan
              xml.nombre nombre
              xml.numero_de_control numero_de_control
              xml.carrera carrera
              xml.nivel nivel
              xml.periodo periodo
              xml.fecha fecha
              xml.cadena_comprobacion cadena_comprobacion
              
            }
          }
        end
# Guardar el documento XML en un archivo
File.open(Rails.root.join('public', 'uploads', "#{nombre}.xml"), "w") do |file|
 file.write(builder.to_xml(encoding: 'UTF-8'))
  # Obtenemos el valor del elemento ASUNTO si existe

end

  
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
      params.require(:documento).permit(:oficio, :asunto, :fecha, :planestudos, :seccion, :numerocontrol, :nombre,:estatus, :archivo_pdf, uploads: [])
    end
end 