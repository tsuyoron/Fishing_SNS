class Public::CatchesController < ApplicationController
# before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @catch = Catch.find(params[:id])
    @catch_new = Catch.new
    @post_comment = PostComment.new
  end

  def index
    @catch = Catch.new
    @catches = Catch.all
  end

  def create
    @catch = Catch.new(catch_params)
    @catch.user_id = current_user.id
    if @catch.save
      redirect_to catch_path(@catch), notice: "You have created book successfully."
    else
      @catchs = Catch.all
      render 'index'
    end
  end

  def edit
    @catch = Book.find(params[:id])
  end

  def update
    @catch = Catch.find(params[:id])
    if @catch.update(catch_params)
      redirect_to catch_path(@catch), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @catch = Book.find(params[:id])
    @catch.destroy
    redirect_to catches_path
  end

  private

  def catch_params
    params.require(:catch).permit(:title,:body)
  end

  def ensure_correct_user
    @catch = Catch.find(params[:id])
    unless current_user == @catch.user
      redirect_to catches_path
    end
  end
end
