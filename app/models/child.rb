class Child < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Person'
end