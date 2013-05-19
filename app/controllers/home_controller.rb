class HomeController < ApplicationController
  include HomeHelper

  def index
    @first, @second, @third = Events.order("numInvited DESC").limit(3)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
