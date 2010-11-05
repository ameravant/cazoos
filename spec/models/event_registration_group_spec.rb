require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventRegistrationGroup do
  before(:each) do
    @event = Factory(:random_event)
    @owner = Factory(:random_person)
    @valid_attributes = {
      :title => "jason's group",
      :event_id => @event.id,
      :public => true,
      :owner_id => @owner.id,
      :is_attending => true,
      :type => "EventRegistrationGroup"
    }
  end

  it "should create a new instance given valid attributes" do
    EventRegistrationGroup.create!(@valid_attributes)
  end
  it "should be a person group" do
    # This line fails, but the other passes.  Problem with any_instance method perhaps ???
#    EventRegistrationGroup.any_instance.is_a?(PersonGroup).should == true
    EventRegistrationGroup.new.is_a?(PersonGroup).should == true
  end
  it "should calculate a total" do
    pending
    # The last line errors out, b/c there is no "total" method defined.  Ask Jason to clarify
#    @owner = Factory(:random_person)
#    @guests = threeTimes{Factory(:random_person)}
#    @event_group = Factory(:random_registration_group,
#                           :event_id => @event.id,
#                           :owner_id => @owner.id
#                           )
#    @price_options = threeTimes{Factory(:random_event_price_option)}
#    @guests.each_with_index do |g, i|
#      Factory(:event_registration,
#              :event_registration_group_id => @event_group.id,
#              :person_id => g.id,
#              :event_price_option_id => @price_options[i]
#              )
#    end
#    @event_group.subtotal.should == @price_options.sum{|p| p.price }
  end
end