class LessonCategoriesController < ApplicationController

  def index 
    @categories = LessonCategory.all
  end

  def new
    @new_category = LessonCategory.new
  end

  def create
    @new_category = LessonCategory.new({name: params[:input_category_name], 
      description: params[:input_description]})
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

  def update
    @category = LessonCategory.find_by(id: params[:id])
    @category.update_attributes({name: params[:input_category_name], 
      description: params[:input_description]})
  end

  def destroy
    category = LessonCategory.find_by(id: params[:id])
    category.destroy
  end
end
