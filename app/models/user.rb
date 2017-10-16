class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format:{with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, presence: true, on: :create
  before_save :downcase_fields

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  def downcase_fields
    self.email.downcase!
  end

end
