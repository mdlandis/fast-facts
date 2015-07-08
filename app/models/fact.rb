class Fact < ActiveRecord::Base
  belongs_to :source
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => true
end
