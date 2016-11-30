class Admin < ActiveRecord::Base
    validates :uin, presence: true
end