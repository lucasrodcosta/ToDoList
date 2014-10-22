class List
  include Mongoid::Document
  include Mongoid::Enum

  belongs_to :user
  has_many :tasks, dependent: :destroy

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

  def progress
    total = self.tasks.count
    return 0 if total == 0

    done = self.tasks.select{ |t| t.done? }.count
    100*(done/total).round(0)
  end

end
