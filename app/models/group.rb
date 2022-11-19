class Group < ApplicationRecord
    validates :groupname, presence: true
    paginates_per 10
end
