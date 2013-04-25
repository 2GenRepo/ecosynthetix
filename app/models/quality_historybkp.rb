class QualityHistory < ActiveRecord::Base
  belongs_to :quality
  belongs_to :user
end
