require "spec_helper"
require "rails_helper"

RSpec.describe User, type: :model do
  before :each do
    User.destroy_all
    List.destroy_all
    Task.destroy_all
  end

  it 'return false because the user has no favorite lists' do
    user = User.create!(email: 'foo@gmail.com', password: '123abc456')
    list = List.create!(user: user, name: 'Teste', description: 'Teste')

    expect(user.has_this_list_as_favorite?(list)).to eq(false)
  end

  it 'return true because the user has the list as favorite' do
    user = User.create!(email: 'foo@gmail.com', password: '123abc456')
    list = List.create!(user: user, name: 'Teste', description: 'Teste')
    favorite = FavoriteList.create!(user: user, list: list)

    expect(user.has_this_list_as_favorite?(list)).to eq(true)
  end
end