class Tag < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :facts
  validates_uniqueness_of :tag_word

end
