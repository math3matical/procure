class EngineersController < ApplicationController
  def index
    @engineers = Engineer.search(params[:search])
  end

  def show
    @engineers = Engineer.find(params[:id])
  end

  def edit
    puts "============================"
    puts params
    puts "============================"
    @engineer = Engineer.find(params[:id])
  end

  def create
    @engineer = Engineer.new(engineer_params)

    if @engineer.save
      redirect_to @engineer
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    @engineer = Engineer.find(params[:id])

    if @engineer.update(engineer_params)
      redirect_to @engineer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @engineer = Engineer.new
  end

  def bugs
    puts "================================================================================================================"
    puts "engineer bugs"
    puts params
    puts "================================================================================================================"
    @engineer = Engineer.find(params[:id])
    @engineer.bugs
  end

  def destroy
    @engineer = Engineer.find(params[:id])
    @engineer.destroy

    redirect_to engineers_path, status: :see_other
  end

  private
    def engineer_params
      params.require(:engineer).permit(:first_name, :last_name, :irc, :position, :status, :search)
    end



end
