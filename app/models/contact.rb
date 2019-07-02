class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || "is not an email")
      end
    end
  end

  validates :email, uniqueness: true, email: true

  def friendly_updated_at
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japanese_number
    "+81 #{phone_number}"
  end
end
