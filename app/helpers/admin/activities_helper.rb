module Admin::ActivitiesHelper

  def activity_has_category?(act, cat)
    act.activity_category_ids.include? cat.id
  end

end