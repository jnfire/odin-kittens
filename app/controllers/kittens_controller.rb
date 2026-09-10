class KittensController < ActionController::API
  before_action :set_kitten, only: %i[ show update destroy ]

  def index
    @kittens = Kitten.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      render :show, formats: :json, status: :created, location: @kitten
    else
      render json: @kitten.errors, status: :unprocessable_content
    end
  end

  def update
    if @kitten.update(kitten_params)
      render :show, formats: :json, status: :ok, location: @kitten
    else
      render json: @kitten.errors, status: :unprocessable_content
    end
  end

  def destroy
    @kitten.destroy!
    head :no_content
  end

  private
    def set_kitten
      @kitten = Kitten.find(params.expect(:id))
    end

    def kitten_params
      params.expect(kitten: [ :name, :age, :cuteness, :softness ])
    end
end
