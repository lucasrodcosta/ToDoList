class Task
  include Mongoid::Document

  belongs_to :list

  field :name,        type: String
  field :description, type: String
  field :done,        type: Boolean

  validates_presence_of :name
end
