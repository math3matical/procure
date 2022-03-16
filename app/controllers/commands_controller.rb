class CommandsController < ApplicationController
  def index
    session[:command_sort] ||=0
    @commands = Command.search(params[:search])
    if session[:filter].length > 0
      @commands = @commands.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'")
    end
    @commands=@commands.order(:name)
    session[:command_sort]+=1 if params[:sort]
    @commands=@commands.reverse unless session[:command_sort]%2==0
  end

  def show
    @command = Command.find(params[:id])
  end

  def new
    @command = Command.new
  end

  def create
    @command = Command.new(command_params)

    if @command.save
      redirect_to @command
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @command = Command.find(params[:id])
  end

  def update
    @command = Command.find(params[:id])

    if @command.update(command_params)
      redirect_to @command
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @command = Command.find(params[:id])
    @command.destroy
    redirect_to commands_path, status: :see_other
  end

  private
    def command_params
      params.require(:command).permit(:name, :body, :status, :search)
    end
end
