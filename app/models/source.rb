class Source < ActiveRecord::Base
  has_many :facts
  ORIG_SOURCE_OPTIONS = ["Yes", "No"]

  accepts_nested_attributes_for :facts, allow_destroy: true, reject_if: lambda { |a| a[:fact_text].blank? }
end
