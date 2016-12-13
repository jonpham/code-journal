class LessonModulesController < ApplicationController

  def index
  # User LessonModule Dashboard
  # @user_sessions = current_user.lesson_sessions
  end

  def show
    @module = LessonModule.find_by(id: params[:id])
  end

  def edit
    @module = LessonModule.find_by(id: params[:id])
  end

  def update
    @module = LessonModule.find_by(id: params[:id])
    @module.update_attributes({
      lesson_id: params[:lesson_id]
    })
    redirect_to "/lesson_modules/#{@module.id}"
  end

  def new
    @new_module = LessonModule.new
  end

  def create
    @new_module = LessonModule.new({
      lesson_id: params[:lesson_id]
    })
    @new_module.save
    redirect_to "/lessons/#{params[:lesson_id]}"
  end

  def destroy
    @module = LessonModule.find_by(id: params[:id])
    @module.destroy
    redirect_to "/lessons/#{params[:lesson_id]}"
  end
end
