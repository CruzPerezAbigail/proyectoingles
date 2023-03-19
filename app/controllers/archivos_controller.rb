require 'digest/md5'
require 'nokogiri'
require 'builder'
class ArchivosController < ApplicationController
  before_action :set_archivo, only: %i[ show edit update destroy ]

  # GET /documentos or /documentos.json
  def index
    @archivos = Archivo.all
  end

  # GET /documentos/1 or /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @archivo = Archivo.new
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos or /documentos.json
  def create
    @archivo = Archivo.new(documento_params)

    respond_to do |format|
      if @archivo.save
        format.html { redirect_to documento_url(@archivo), notice: "Documento was successfully created." }
        format.json { render :show, status: :created, location: @archivo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @archivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos/1 or /documentos/1.json
  def update
    respond_to do |format|
      if @archivo.update(archivo_params)
        format.html { redirect_to documento_url(@archivo), notice: "Documento was successfully updated." }
        format.json { render :show, status: :ok, location: @archivo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @archivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1 or /documentos/1.json
  def destroy
    @archivo.destroy

    respond_to do |format|
      format.html { redirect_to archivo_url, notice: "Documento was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def subir_archivo
    file = params[:id]

    file_contents = file.read()
    md5_hash = Digest::MD5.hexdigest(file_contents)
    puts "el hasd md5 del archivo #{file.original_filename} es: #{md5_hash}"
 end 

  # DELETE /archivos/1 or /archivos/1.json
 private
 def set_archivo
  @archivo = Archivo.find(params[:id])
end

    # Only allow a list of trusted parameters through.
    def archivo_params
      params.require(:archivo).permit(uploads:[])
    end
end
