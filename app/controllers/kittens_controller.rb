class KittensController < ApplicationController
  before_action :set_kitten, only: %i[ show update destroy ]

  # GET /kittens or /kittens.json
  def index
    @kittens = Kitten.all
  end

  # GET /kittens/1 or /kittens/1.json
  def show
  end

  # POST /kittens or /kittens.json
  def create
    @kitten = Kitten.new(kitten_params)

    respond_to do |format|
      if @kitten.save
        format.json { render :show, status: :created, location: @kitten }
        format.xml { render :show, status: :created, location: @kitten }
      else
        format.json { render json: @kitten.errors, status: :unprocessable_content }
        format.xml { render xml: @kitten.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /kittens/1 or /kittens/1.json
  def update
    respond_to do |format|
      if @kitten.update(kitten_params)
        format.json { render :show, status: :ok, location: @kitten }
        format.xml { render :show, status: :ok, location: @kitten }
      else
        format.json { render json: @kitten.errors, status: :unprocessable_content }
        format.xml { render xml: @kitten.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /kittens/1 or /kittens/1.json
  def destroy
    @kitten.destroy!

    respond_to do |format|
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kitten
      @kitten = Kitten.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def kitten_params
      params.expect(kitten: [ :name, :age, :cuteness, :softness ])
    end
end
