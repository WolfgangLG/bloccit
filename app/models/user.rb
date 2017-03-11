class User < ActiveRecord::Base
  before_save :email_downcase, :titleize_name

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 254 }

  has_secure_password

  private

  def email_downcase
    self.email = email.downcase if email.present?
  end

  def titleize_name
    self.name = self.name.split.map { |name| name.capitalize! }.join(" ")
  end
end
