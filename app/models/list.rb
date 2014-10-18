class List
  include Mongoid::Document
  include Mongoid::Enum

  belongs_to :user
  has_many :tasks

  field :name,        type: String
  field :description, type: String

  # a user list can be private or public
  enum :visibility, [:private, :public]

  # a user can't have two lists with same name
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :name


  def self.visibility_enum
    [["Privada", :private], ["Pública", :public]]
  end

end
