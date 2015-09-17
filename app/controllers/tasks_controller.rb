class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  respond_to :html
 
  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = 'Task was successfully created.'      
    end
    respond_with(@task)
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task was successfully updated.'      
    end
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task, location: tasks_url)    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "Wrong params"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date)
    end
end
