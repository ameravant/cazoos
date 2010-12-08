class Admin::EventsController < AdminController

  def index
    if params[:q].blank?
      add_breadcrumb @cms_config['site_settings']['events_title']
      @all_events = Event.all
    else
      add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
      add_breadcrumb "Search"
      @all_events = Event.find :all, :conditions => ["name like ?", "#{params[:q]}%"], :order => "date_and_time desc"
    end
    # This has to be by offering, not all events
    @events = @all_events.sort_by(&:date_and_time).reverse.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @event_categories = EventCategory.active
    @event = Event.new
    @org = Org.find(params[:org_id]) if params[:org_id]
  end

  def create
    @event = Event.new(params[:event])
    @event.event_price_options.build(params[:event_price_options])
    if @event.save
      flash[:notice] = "Event created, would you like to add price options"
      redirect_to new_admin_event_event_price_option_path(@event)
    else
      render :action => "new"
    end
  end
end

