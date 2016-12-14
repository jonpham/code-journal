class LessonsController < ApplicationController

  def index
    # User Lesson Dashboard
    # @user_sessions = current_user.lesson_sessions
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def edit
    @lesson = Lesson.find_by(id: params[:id])
  end

  def update
    @lesson = Lesson.find_by(id: params[:id])
    @lesson.update_attributes({
      name: params[:input_name],
      concept: params[:input_concept],
      purpose: params[:input_purpose],         
      description: params[:input_description],
      example: params[:input_example],
      lesson_category_id: params[:lesson_category][:lesson_category_id]
    })
    redirect_to "/lessons/#{@lesson.id}"
  end

  def new
    @new_lesson = Lesson.new
  end

  def create
    @new_lesson = Lesson.new({
      name: params[:input_lesson_name],
      concept: params[:input_concept],
      purpose:   params[:input_purpose],         
      description: params[:input_description],
      example: params[:input_example],
      lesson_category_id: params[:lesson_category][:lesson_category_id]
    })
    @new_lesson.save
    
    sample_module = LessonModule.create({
        lesson_id: @new_lesson.id,
        lesson_ordinal: 0,
        description: "Lesson #{@new_lesson.name}: Module 0"
    })

    redirect_to '/lesson_categories'
  end

  def destroy
    @lesson = Lesson.find_by(id: params[:id])
    @lesson.destroy
    redirect_to '/lesson_categories'
  end
end
