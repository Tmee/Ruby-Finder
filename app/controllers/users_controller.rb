class UsersController < ApplicationController

  def update
    current_user.update(user_params)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:note)
  end
end
