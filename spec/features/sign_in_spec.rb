require "spec_helper"
require "rails_helper"

feature "Signing in" do
  User.destroy_all
  List.destroy_all
  Task.destroy_all

  User.create!(email: 'foo@gmail.com', password: '123abc456')

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'foo@gmail.com'
      fill_in 'Password', with: '123abc456'
    end
    click_button 'Log in'
    expect(page).to have_css('.add-list-content', 'Add-list div')
  end

  scenario "Signing in with incorrect email" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'foo@outlook.com'
      fill_in 'Password', with: '123abc456'
    end
    click_button 'Log in'
    expect(current_path).to eq('/users/sign_in')
  end
end