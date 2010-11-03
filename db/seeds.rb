# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Create PersonGroups.  'Admin' will be used for permissions.  Others will be for email bulletins
admin_group = PersonGroup.create(:title => "Admin", :role => true, :public => false, :description => "Has access to all areas of the CMS.")
owner_group = PersonGroup.create( :title => "Organization Owner", :role => true, :public => false, :description => "Can login and manage his/her camp, camp offerings and schedules")
parent_group = PersonGroup.create(:title => "Parent", :role => true, :public => false, :description => "A parent with children in the Cazoos system")
# PersonGroup.create(:title => "Child", :role => true, :public => false, :description => "A child in the system")

# Create 'admin' user
person = Person.create(:first_name => "admin", :last_name => "admin", :email => "admin@mailinator.com")
user = User.create( { :login => 'admin', :password => 'admin', :password_confirmation => 'admin' } )
user.person_id = person.id
person.person_groups << admin_group
user.is_admin = true
user.save

# Create Settings table data
Setting.create(
  :newsletter_from_email => 'admin@ameravant.com',
  :footer_text => '<p style="text-align: center;">&copy; 2008-#YEAR# Site-Ninja.com</p>
<p style="text-align: center;"><a href="/" class="icon"><img title="SiteNinja Homepage" src="/system/files/1/thumb/ninja_black.png" alt="Black Ninja" width="48" height="45" border="0" /></a></p>',
  :inquiry_notification_email => "contact@ameravant.com",
  :comment_profanity_filter => true,
  :events_range => 3,
  :tracking_code => '<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src=\'" + gaJsHost + "google-analytics.com/ga.js\' type=\'text/javascript\'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-7311013-1");
pageTracker._trackPageview();
} catch(err) {}</script>'
)

# Create pages and menus
@cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
home = Page.create(:title => 'Home', :body => 'home',
  :meta_title => "Home", :permalink => "home", :can_delete => false, :position => 1)
  Page.create(:title => 'About Us', :body => 'About', :meta_title => "About #{@cms_config['website']['name']}")
  Page.create(:title => 'Blog', :meta_title => 'Blog', :body => "blog", :permalink => "blog", :can_delete => false) if @cms_config['modules']['blog']
  Page.create(:title => 'Images', :meta_title => 'Galleries', :body => "galleries", :permalink => "galleries", :can_delete => false) if @cms_config['modules']['galleries']
  Page.create(:title => 'Products', :meta_title => 'Products', :body => "Products", :permalink => "products", :can_delete => false) if @cms_config['modules']['product']
  contact = Page.create( :title => 'Contact Us', :body => "<h1>Contact #{@cms_config['website']['name']}</h1>", :meta_title => "Contact #{@cms_config['website']['name']}", :permalink => "inquire")
  Page.create(:title => 'Members', :meta_title => 'members', :body => "members", :permalink => "members", :can_delete => true) if @cms_config['modules']['members']
  Page.create(:title => 'Profiles', :meta_title => 'profiles', :body => "profiles", :permalink => "profiles", :can_delete => true) if @cms_config['modules']['profiles']
  Page.create(:title => 'Links', :meta_title => 'Links', :body => "links", :permalink => "links", :can_delete => false) if @cms_config['modules']['links']
  Page.create(:title => 'Testimonials', :body => 'Testimonials', :meta_title => 'Testimonials', :show_in_footer => true, :can_delete => false, :parent_id => home.id) if @cms_config['features']['testimonials']
  Page.create(:parent_id => contact.id, :title => 'Contact Us - Thank You', :body => 'Thank you for your inquiry. We usually respond within 24 hours.', :meta_title => "Message sent", :permalink => "inquiry_received", :status => 'hidden', :show_in_footer => false)
  Page.create(:parent_id => contact.id, :title => 'Privacy Policy',:show_articles => false,:show_events => false, :show_in_footer => true, :show_in_menu => false, :body => 'This page can be helpful when creating a privacy policy <a href="http://www.freeprivacypolicy.com/privacy.php">http://www.freeprivacypolicy.com/privacy.php</a>', :meta_title => "Privacy Policy")
  Page.create(:parent_id => contact.id, :title => 'Terms of Use', :show_articles => false,:show_events => false, :show_in_footer => true, :show_in_menu => false, :body => 'Terms of Use', :status => 'hidden', :meta_title => "Terms of Use")
  for page in Page.all
    if page.menus.empty?
      menu = page.menus.new
      menu.save
    end
  end
  for menu in Menu.all
    page = menu.navigatable
    unless page.parent_id.blank?
      parent_page = Page.find(page.parent_id)
      menu.parent_id = parent_page.menus.first.id
    end
    menu.position = page.position
    menu.footer_pos = page.footer_pos
    menu.show_in_footer = page.show_in_footer
    menu.can_delete = page.can_delete
    menu.status = page.status
    menu.save
  end

Plugin.create(:url => "git@github.com:ameravant/siteninja_core.git", :position => 1)
Plugin.create(:url => "git@github.com:ameravant/siteninja_pages.git", :position => 11)
Plugin.create(:url => "git@github.com:ameravant/siteninja_blogs.git", :position => 3) if @cms_config['modules']['blog']
Plugin.create(:url => "git@github.com:ameravant/siteninja_documents.git", :position => 4) if @cms_config['modules']['documents']
Plugin.create(:url => "git@github.com:ameravant/siteninja_events.git", :position => 5) if @cms_config['modules']['events']
Plugin.create(:url => "git@github.com:ameravant/siteninja_galleries.git", :position => 6) if @cms_config['modules']['galleries']
Plugin.create(:url => "git@github.com:ameravant/siteninja_links.git", :position => 7) if @cms_config['modules']['links']
Plugin.create(:url => "git@github.com:ameravant/siteninja_newsletters.git", :position => 8) if @cms_config['modules']['newsletters']
Plugin.create(:url => "git@github.com:ameravant/siteninja_store.git", :position => 9) if @cms_config['modules']['product']
Plugin.create(:url => "git@github.com:ameravant/cazoos.git", :position => 10)
Plugin.create(:url => "git@github.com:ameravant/cazoos_pages.git", :position => 12)


if RAILS_ENV == 'development'
  owner = OrgOwner.new(:first_name => 'Org', :last_name => 'Owner', :email => 'owner@org.org')
  owner.user = User.create(:login => 'owner@org.org', :password => 'secret', :password_confirmation => 'secret')
  owner.person_groups = [ owner_group ]
  owner.save
  
  org_type = OrgType.create(:title => 'Camp', :description => 'Camps')
  
  org = Org.new(:name => 'Camp Something', :description => 'A camp...', :min_age => 6, :max_age => 9, :contact => 'Jim Adams', :contact_phone => '80522288288', :contact_email => 'jim@adams.com', :address => '1234 Org St.', :city => 'Santa Barbara', :state => 'CA', :zip => '93101', :gender => 'coed')
  org.org_type = org_type
  org.owner = owner
  org.save
  
  ActivityCategory.create(:name => 'Horseback Riding', :description => 'Fun for everyone involved. Even the horse likes it!')
  ActivityCategory.create(:name => 'Soccer', :description => 'Not just a passing fad; the next World Cup is in four short years!')
end