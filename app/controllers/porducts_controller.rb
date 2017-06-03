class PorductsController < ApplicationController
  before_action :set_porduct, only: [:show, :edit, :update, :destroy]

  # GET /porducts
  # GET /porducts.json
  def index
    @porducts = Porduct.all
  end

  # GET /porducts/1
  # GET /porducts/1.json
  def show
  end

  # GET /porducts/new
  def new
    @porduct = Porduct.new
  end

  # GET /porducts/1/edit
  def edit
  end

  # POST /porducts
  # POST /porducts.json
  def create
    @porduct = Porduct.new(porduct_params)

    respond_to do |format|
      if @porduct.save
        format.html { redirect_to @porduct, notice: 'Porduct was successfully created.' }
        format.json { render :show, status: :created, location: @porduct }
      else
        format.html { render :new }
        format.json { render json: @porduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /porducts/1
  # PATCH/PUT /porducts/1.json
  def update
    respond_to do |format|
      if @porduct.update(porduct_params)
        format.html { redirect_to @porduct, notice: 'Porduct was successfully updated.' }
        format.json { render :show, status: :ok, location: @porduct }
      else
        format.html { render :edit }
        format.json { render json: @porduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /porducts/1
  # DELETE /porducts/1.json
  def destroy
    @porduct.destroy
    respond_to do |format|
      format.html { redirect_to porducts_url, notice: 'Porduct was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_porduct
      @porduct = Porduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def porduct_params
      params.fetch(:porduct, {})
    end
end
