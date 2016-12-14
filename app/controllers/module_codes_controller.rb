class ModuleCodesController < ApplicationController

  def index
  # User ModuleCode Dashboard
  # @user_sessions = current_user.lesson_sessions
  end

  def show
    @code = ModuleCode.find_by(id: params[:id])
  end

  def edit
    @code = ModuleCode.find_by(id: params[:id])
  end

  def update
    @code = ModuleCode.find_by(id: params[:id])
    @code.update_attributes({
      lesson_id: params[:lesson_id],
      lesson_ordinal: params[:lesson_ordinal]
    })
    redirect_to "/lesson_codes/#{@code.id}"
  end

  def new
    @new_code = ModuleCode.new
  end

  def create
    @new_code = ModuleCode.new({
      lesson_module_id: params[:module_id],
    })
    @new_code.save
    redirect_to "/lessons/#{params[:lesson_id]}"
  end

  def destroy
    @code = ModuleCode.find_by(id: params[:id])
    @code.destroy
    redirect_to "/lessons/#{params[:lesson_id]}"
  end
end
