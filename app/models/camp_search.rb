class CampSearch < ActiveRecord::Base
  def events
    find_events
  end

  private

  def find_events
    Event.find(:all, :conditions => conditions)
  end

  def minimum_age_conditions
    ["events.max_age >= ?", age] unless age.blank?
  end

  def maximum_age_conditions
    ["events.min_age <= ?", age] unless age.blank?
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end