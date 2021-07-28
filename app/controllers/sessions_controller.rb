class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])

    if @user && @user.authenticate(params[:login][:password])
      login @user
      #success message
      redirect_to @user
    else
      #err message
      back_or_url
    end
  end

  def destroy
    logout
    redirect_to "/"
  end
end
