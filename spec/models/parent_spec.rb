require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parent do
  it "should respond to 'children'" do
    parent = Factory :parent
    parent.should respond_to(:children)
  end
end