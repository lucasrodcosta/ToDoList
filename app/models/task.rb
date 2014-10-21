class Task
  include Mongoid::Document

  belongs_to :list

  field :description, type: String
  field :date,        type: DateTime
  field :done,        type: Boolean, default: false

  validates_presence_of :description
end
