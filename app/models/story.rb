class Story < ApplicationRecord
  belongs_to :epic
  has_many :subtasks
end
