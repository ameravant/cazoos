class OrgsController < ApplicationController
  def show
    @org = Org.find(params[:id])
  end
  def index
    @orgs = Org.all
  end
end