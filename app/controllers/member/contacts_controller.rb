class Member::ContactsController < ApplicationController

  def new
  end

  def create
  end

  def confirm
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

end
