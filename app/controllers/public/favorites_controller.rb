class Public::FavoritesController < ApplicationController
  def create
    catch = Catch.find(params[:catch_id])
    current_user.favorites.create({catch_id: catch.id})
    redirect_to catch_path(catch)
  end

  def destroy
    catch = Catch.find(params[:catch_id])
    favorite = current_user.favorites.find_by(catch_id: catch.id)
    favorite.destroy
    redirect_to catch_path(catch)
  end
end
