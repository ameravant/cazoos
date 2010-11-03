require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ChildrenController do
  describe "routing" do
    before :each do
      set_up_record_stub :parent
      @cont = 'admin/children'
    end

    it "should have a route for a parent's children" do
      assert_recognizes( {:controller => @cont, :action => 'index', :parent_id => "#{@parent.id}"},
        admin_parent_children_path(@parent))
      assert_recognizes( {:controller => @cont, :action => 'index', :parent_id => "#{@parent.id}"},
        "/admin/parents/#{@parent.id}/children")
    end
    it "should have a route for a new child for a parent" do
      assert_recognizes( {:controller => @cont, :action => 'new', :parent_id => "#{@parent.id}"},
        new_admin_parent_child_path(@parent))
      assert_recognizes( {:controller => @cont, :action => 'new', :parent_id => "#{@parent.id}"},
        "/admin/parents/#{@parent.id}/children/new")
    end
    it "should have a route for a parent creating a child" do
      assert_recognizes( {:controller => @cont, :action => 'create', :parent_id => "#{@parent.id}"},
        { :path => "/admin/parents/#{@parent.id}/children/", :method => 'post' })      
    end
    it "should have a route for a parent editing their child" do
      set_up_record_stub :child
      assert_recognizes( {:controller => @cont, :action => 'edit', :parent_id => "#{@parent.id}", :id => "#{@child.id}"},
        edit_admin_parent_child_path(@parent, @child))
      assert_recognizes( {:controller => @cont, :action => 'edit', :parent_id => "#{@parent.id}", :id => "#{@child.id}"},
        "/admin/parents/#{@parent.id}/children/#{@child.id}/edit")
    end
    it "should have a route for a parent updating their child's record" do
      set_up_record_stub :child
      assert_recognizes( {:controller => @cont, :action => 'update', :parent_id => "#{@parent.id}", :id => "#{@child.id}"},
        { :path => "/admin/parents/#{@parent.id}/children/#{@child.id}", :method => 'put' } )
    end
  end
end
