require "spec_helper"
require "rails_helper"

feature "Mark a list as favorite" do
  User.destroy_all
  List.destroy_all
  Task.destroy_all

  User.create!(email: 'foo@gmail.com', password: '123abc456')
  User.create!(email: 'bar@gmail.com', password: '123abc456')

  scenario "User 1 create a list and some tasks. User 2 mark the list created by User 1 as favorite", js: true do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'foo@gmail.com'
      fill_in 'Password', with: '123abc456'
    end
    click_button 'Log in'

    click_link 'Criar nova lista'
    within('#list-modal') do
      expect(page).to have_css('.modal-body')

      fill_in 'Nome', with: 'Lista Teste'
      fill_in 'Descrição', with: 'Lista Teste'
      select 'Pública', from: 'Visibilidade'
      page.find('#create-list').click
      sleep 1
      expect(current_path).to eq('/tasks')
    end

    click_link 'Adicionar tarefa'
    within('#task-modal') do
      expect(page).to have_css('.modal-body')

      fill_in 'Descrição', with: 'Tarefa teste'
      page.find('#create-task').click
      sleep 1
      expect(current_path).to eq('/tasks')
    end

    click_link 'Adicionar tarefa'
    within('#task-modal') do
      expect(page).to have_css('.modal-body')

      fill_in 'Descrição', with: 'Tarefa teste 2'
      page.find('#create-task').click
      sleep 1
      expect(current_path).to eq('/tasks')
    end

    visit(current_url)
    within('.table') do
      expect(page).to have_content('Editar descrição')
    end
  end

  scenario "User 2: mark the list created by User 1 as favorite", js: true do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'bar@gmail.com'
      fill_in 'Password', with: '123abc456'
    end
    click_button 'Log in'

    visit '/lists/explore'
    within('.table') do
      page.find('.favorite-list-status').click
    end

    visit '/lists/explore'
    within('.table') do
      expect(page.find('.favorite-list-status > img')['src']).to have_content('yellow_star_icon.png')
    end
  end

end