class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password]) && user.active
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    elsif not user.active

      redirect_to :back, notice: "Account frozen, please contact administration"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
    # uudelleen ohjataan käyttäjä omalle sivulleen

  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
