class Task
  include Mongoid::Document
  include Mongoid::Enum

  belongs_to :list

  field :description, type: String
  field :done,        type: Boolean, default: false

  validates_presence_of :description

end
