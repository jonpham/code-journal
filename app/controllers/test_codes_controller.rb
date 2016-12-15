class TestCodesController < ApplicationController

  def index
  end

  def show
    @test_code = TestCode.find_by(id: params[:id])
  end

  def edit
    @test_code = TestCode.find_by(id: params[:id])
  end

  def update
    @test_code = TestCode.find_by(id: params[:id])
    @test_code.update_attributes({
      module_code_id: params[:module_code_id].to_i
    })
    redirect_to "/module_codes/#{@test_code.module_code.id}/edit"
  end

  def new
    @test_code = TestCode.new
  end

  def create
    @test_code = TestCode.new({
      module_code_id: params[:module_code_id]
    })
    @test_code.save
    redirect_to "/module_codes/#{@test_code.module_code.id}/edit"
  end

  def destroy
    @test_code = TestCode.find_by(id: params[:id])
    lesson_module_id = @test_code.module_code.lesson_module.id
    @test_code.destroy
    redirect_to "/lesson_modules/#{lesson_module_id}"
  end

end
