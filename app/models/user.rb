class User < ApplicationRecord
    scope :sorted, lambda { order("name ASC") }
    scope :search, lambda {|query| where(["name LIKE ? OR email LIKE?", "%#{query}%".titleize, "%#{query}%" ])}
    
    validates_presence_of :name
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    before_save :sanitize_name

    def sanitize_name
      self.name = self.name.titleize
    end

end
