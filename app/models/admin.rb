class Admin < ActiveRecord::Base
    validates :uin, presence: true
    validates_format_of :uin, :with => /^\d+$/, :multiline => true
end