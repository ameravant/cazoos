class CampSearchesController < ApplicationController
  before_filter :find_page
  def new
    @search = CampSearch.new
  end

  def create
    @search = CampSearch.new(params[:camp_search])
    if @search.save
      redirect_to :action => 'show', :id => @search.id
    else
      render :new
    end
  end

  def show
    @search = CampSearch.find(params[:id])
  end

  private
  def find_page
    @page = Page.find_by_permalink("search")
  end
end