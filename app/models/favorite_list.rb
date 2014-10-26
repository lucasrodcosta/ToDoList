class FavoriteList
  include Mongoid::Document

  belongs_to :user
  belongs_to :list

  field :active, type: Boolean, default: true

  def self.active_favorite_lists(user)
    user.favorite_lists.where(active: true)
  end

  def mark_as_active
    self.active = true
    self.save
  end

  def mark_as_inactive
    self.active = false
    self.save
  end
end
