class LessonModulesController < ApplicationController

  def index
  # User LessonModule Dashboard
  # @user_sessions = current_user.lesson_sessions
    @lesson = Lesson.find_by(id: params[:lid])
  end

  def show
    @module = LessonModule.find_by(id: params[:id])
    @lesson = @module.lesson
  end

  def edit
    @module = LessonModule.find_by(id: params[:id])
    @lesson = @module.lesson
  end

  def update
    @module = LessonModule.find_by(id: params[:id])
    @module.assign_attributes({
      lesson_id: params[:lesson_id],
      lesson_ordinal: params[:lesson_ordinal],
      description: params[:input_description]
    })
    @module.save
    redirect_to "/lesson_modules/#{@module.id}"
  end

  def new
    @new_module = LessonModule.new
  end

  def create
    lesson = Lesson.find_by(id: params[:lesson_id])
    @new_module = LessonModule.new({
      lesson_id: params[:lesson_id],
      lesson_ordinal: lesson.get_next_ordinal,
      description: params[:input_description]
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
