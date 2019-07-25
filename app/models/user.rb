class User < ApplicationRecord
    scope :sorted, lambda { order("name ASC") }
    scope :search, lambda {|query| where(["name LIKE ? OR email LIKE?", "%#{query}%".titleize, "%#{query}%" ])}
    
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    before_save :sanitize_name

    def sanitize_name
      self.name = self.name.titleize
    end

end
