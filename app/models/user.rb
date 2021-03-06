class User
  include Mongoid::Document

  has_many :lists,          dependent: :destroy
  has_many :favorite_lists, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # user email must be unique
  validates_uniqueness_of :email

  # Workaround to solve the issue with Devise and Mongoid 4
  # https://github.com/plataformatec/devise/issues/2949
  def self.serialize_from_session(key, salt)
    record = to_adapter.get(key[0]["$oid"])
    record if record && record.authenticatable_salt == salt
  end

  def has_this_list_as_favorite?(list)
    (self.favorite_lists.where(list: list).count > 0) ? true : false
  end

  def active_favorite_lists
    FavoriteList.active_favorite_lists(self)
  end
end
