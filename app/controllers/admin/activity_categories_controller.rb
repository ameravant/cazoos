class Admin::ActivityCategoriesController < AdminController
  def index
    @activity_categories = ActivityCategory.all
  end
end