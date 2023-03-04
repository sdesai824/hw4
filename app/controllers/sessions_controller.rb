class SessionsController < ApplicationController
  def new
  end

  def index
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/posts"
      else
        flash["notice"] = "Nope."
        redirect_to "/sessions"
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/sessions"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/sessions"
  end
end
  