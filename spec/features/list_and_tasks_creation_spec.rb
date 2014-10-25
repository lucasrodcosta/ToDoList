require "spec_helper"
require "rails_helper"

feature "List and tasks creation" do
  User.destroy_all
  List.destroy_all
  Task.destroy_all

  User.create!(email: 'foo@gmail.com', password: '123abc456')

  scenario "Creating a list and some tasks", js: true do
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

end