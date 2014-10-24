require "spec_helper"
require "rails_helper"

RSpec.describe List, type: :model do
  before :each do
    User.destroy_all
    List.destroy_all
    Task.destroy_all
  end

  it 'a user cannot has 2 lists with same name' do
    user = User.create!(email: 'foo@gmail.com', password: '123abc456')
    List.create!(user: user, name: 'Teste', description: 'Teste', visibility: :private)

    expect{ List.create!(user: user, name: 'Teste', description: 'Teste', visibility: :public) }.to raise_error
  end

  it 'return 1 public list' do
    user = User.create!(email: 'foo@gmail.com', password: '123abc456')
    list1 = List.create!(user: user, name: 'Teste', description: 'Teste', visibility: :private)
    list2 = List.create!(user: user, name: 'Teste2', description: 'Teste', visibility: :public)

    expect(user.lists.count).to eq(2)
    expect(List.get_public_lists.count).to eq(1)
    expect(List.get_public_lists.first).to eq(list2)
  end

end