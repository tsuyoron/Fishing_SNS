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
      tags = Vision.get_image_data(@catch.catch_image)
      tags.each do |tag|
        @catch.tags.create(name: tag)
      end

      redirect_to catch_path(@catch), notice: "You have created catch successfully."
    else
      @catches = Catch.all
      render 'index'
    end
  end

  def edit
    @catch = Catch.find(params[:id])
  end

  def update
    @catch = Catch.find(params[:id])
    if @catch.update(catch_params)
      redirect_to catch_path(@catch), notice: "You have updated catch successfully."
    else
      render "edit"
    end
  end

  def destroy
    @catch = Catch.find(params[:id])
    @catch.destroy
    redirect_to catches_path
  end

  private

  def catch_params
    params.require(:catch).permit(:title,:body, :catch_image)
  end

  def ensure_correct_user
    @catch = Catch.find(params[:id])
    unless current_user == @catch.user
      redirect_to catches_path
    end
  end
end
