class Group < ApplicationRecord
    validates :groupname, presence: true
end
