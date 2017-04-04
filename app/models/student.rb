class Student < ActiveRecord::Base
    validates :full_name, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :uin, presence: true
    # validates_format_of :email, :with => /\A(\w+)@(tamu.edu)\z/i
    validates_format_of :full_name, :with => /\w+/, :multiline => true
    # # attr_accessor :full_name, :email
end