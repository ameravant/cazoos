module CazoosPersonExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def cazoos_person_extra_methods
      # has_many :children, :conditions => { :person_groups => PersonGroup.find_by_title('Parent') }, :class_name => Person
      # has_one :parent, :conditions => { :person_groups => PersonGroup.find_by_title('Child') }, :class_name => Person
      # "should not save a person who belongs to no groups"
      validates_presence_of :person_groups, :message => 'must belong to a group'
      before_validation :validates_parent_exists
      #, :if => :child?
      
      # "should disallow several of the same PersonGroup from being glommed on"
      has_and_belongs_to_many :person_groups, :uniq => true
      include CazoosPersonExt::InstanceMethods
    end
  end
  
  module InstanceMethods
    # def after_find: "should not allow a person in the system to belong to more than one group"
    # I chose after_find b/c it was difficult to intercept the << operator, so this resets every time the person is found
    def after_find
      pgs = self.person_groups.dup
      if pgs.size > 1
        self.person_groups = [ pgs[0] ]
      end
    end

    def person_type
      person_groups[0].title
    end
    
    def children
      Person.all(:conditions => { :parent_id => self.id } )
    end

    def child?
      person_type == 'Child'
    end
    
    protected
    
    def validates_parent_exists
      Person.find(parent_id, :include => :person_group, 
        :conditions => ['people_person_groups.person_group_id=?', PersonGroup.find_by_title('Parent').id]
      ) if child?
    end
  end
  
end
ActiveRecord::Base.send(:include, CazoosPersonExt)
Person.send(:cazoos_person_extra_methods)