class CasesController < ApplicationController
  def index
    puts "0000000000000000000000000000000000000000"
    puts params
    puts "0000000000000000000000000000000000000000"
    if params[:engineer_id]
     
      @engineer = Engineer.find(params[:engineer_id])
      @cases = @engineer.cases
      @name = @engineer.first_name
    else
      @cases = Case.search(params[:search])
    end
  end

  def show
    @cases = Case.find(params[:id])
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)

    if @case.save
      redirect_to @case
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    puts "0000000000000000000000000000000000000000"
    puts params
    puts "0000000000000000000000000000000000000000"
    @case = Case.find(params[:id])
  end

  def update
    puts "0000000000000000000000000000000000000000"
    puts params
    puts "0000000000000000000000000000000000000000"
    @case = Case.find(params[:id])

    if @case.update(case_params)
      redirect_to @case
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @case = Case.find(params[:id])
    @case.destroy
    redirect_to cases_path, status: 303
  end

  private
    def case_params
      params.require(:case).permit(:title, :version, :number, :comments, :importance, :notes, :status, :search)
    end
end
