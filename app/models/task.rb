class Task
  include Mongoid::Document
  include Mongoid::Enum

  belongs_to :list

  field :description, type: String
  field :date,        type: DateTime

  # a task can be undone, in_progress or done
  enum :status, [:undone, :in_progress, :done]

  validates_presence_of :description

  def self.status_enum
    [["Não iniciada", :undone], ["Em andamento", :in_progress], ["Concluída", :done]]
  end

end
