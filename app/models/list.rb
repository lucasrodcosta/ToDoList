class List
  include Mongoid::Document
  include Mongoid::Enum

  after_save :invalidate_favorite_lists_of_private_lists

  belongs_to :user
  has_many :tasks,          dependent: :destroy
  has_many :favorite_lists, dependent: :destroy

  field :name,        type: String
  field :description, type: String

  # a user list can be private or public
  enum :visibility, [:private, :public]

  # a user can't have two lists with same name
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :name


  def self.get_public_lists
    List.where(visibility: :public).all
  end

  def self.visibility_enum
    [["Privada", :private], ["Pública", :public]]
  end

  def progress
    total = self.tasks.count
    return nil if total == 0

    done = self.tasks.select{ |t| t.done? }.count
    (100*done/total.to_f).round(0)
  end

  # - If an user creates an public list and then decide to make this list private,
  #     we must mark all FavoriteLists related to this list as "inactive".
  # - If the user decide to make the list public again, the FavoriteLists become
  #     "active" again too.
  def invalidate_favorite_lists_of_private_lists
    if self.private?
      self.favorite_lists.each do |favorite|
        favorite.mark_as_inactive
      end

    else
      self.favorite_lists.each do |favorite|
        favorite.mark_as_active
      end

    end
  end

end
