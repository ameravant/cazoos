class Admin::OrgsController < AdminController
  def index
    @orgs = Org.all
  end
end