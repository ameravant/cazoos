module Admin::OfferingsHelper

  def offering_has_category?(off, cat)
    off.activity_category_ids.include? cat.id
  end

end