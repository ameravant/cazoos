class Admin::OrgsController < AdminController
  def index
    @orgs = Org.all
  end
  
  def new
    @org = Org.new
  end
end