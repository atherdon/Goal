class TasksController < ApplicationController
  before_action :get_tasks, only: [:index, :create, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
 
  def index
    if params[:q]
      @tasks = get_tasks.search(params[:q])
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.new
    render 'edit'
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash.now[:notice]  = 'Task was successfully created.'      
    end
    render 'update'
  end

  def update
    if @task.update(task_params)
      flash.now[:notice] = 'Task was successfully updated.'      
    end
  end

  def destroy
    @task.destroy
    render 'index'  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "Wrong params"
    end

    def get_tasks
      @tasks = current_user.tasks.page(params[:page])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date)
    end
end
