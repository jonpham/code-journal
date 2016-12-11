class LessonCategoriesController < ApplicationController

  def index 
    @categories = LessonCategory.all
  end

  def new
    @new_category = LessonCategory.new
  end

  def create
    @new_category = LessonCategory.new({category_name: params[:input_category_name], 
      category_description: params[:input_description]})
    if @new_category.save
      redirect_to '/lesson_categories/' # Redirect to lesson Creation Wizard after.
    else
      flash[:danger] = "Something went wrong with the Category Creation!"
      render :new
    end
  end

  def show 
    @category = LessonCategory.find_by(id: params[:id])
  end
end
