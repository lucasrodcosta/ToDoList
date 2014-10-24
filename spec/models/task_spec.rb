require "spec_helper"
require "rails_helper"

RSpec.describe Task, type: :model do
  before :each do
    User.destroy_all
    List.destroy_all
    Task.destroy_all
  end

  it 'a task must has a description' do
    user = User.create!(email: 'foo@gmail.com', password: '123abc456')
    list = List.create!(user: user, name: 'Teste', description: 'Teste', visibility: :private)

    expect{ Task.create!(list: list) }.to raise_error
  end

end