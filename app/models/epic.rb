class Epic < ApplicationRecord
  belongs_to :modul
  has_many :stories
end
