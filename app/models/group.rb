class Group < ApplicationRecord
    validates :groupname, presence: true
    paginates_per 5
end
