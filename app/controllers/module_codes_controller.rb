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
      lesson_module_id: params[:lesson_module_id],
      module_ordinal: params[:module_ordinal],
      method_name: params[:method_name],
      arg_number: params[:arg_number].to_i,
      return_type: params[:return_type],
      source_code: params[:source_code],
    })
    redirect_to "/lesson_modules/#{@code.lesson_module.id}"
  end

  def new
    @new_code = ModuleCode.new
  end

  def create
    lesson_module = LessonModule.find_by(id: params[:lesson_module_id])
    @new_code = ModuleCode.new({
      lesson_module_id: params[:lesson_module_id],
      method_name: params[:method_name],
      arg_number: params[:arg_number].to_i,
      return_type: params[:return_type],
      source_code: params[:source_code],
      module_ordinal: lesson_module.get_next_ordinal
    })
    @new_code.save
    redirect_to "/lesson_modules/#{lesson_module.id}"
  end

  def destroy
    @code = ModuleCode.find_by(id: params[:id])
    lesson_module_id = @code.lesson_module.id
    @code.destroy
    redirect_to "/lesson_modules/#{lesson_module_id}"
  end
end
