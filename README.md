ToDoList
========

Organizador simples de To-Do Lists.

---
#### Pré-requisitos
 - Ruby 2.1.3
 - Rails 4.1.6
 - MongoDB >= 2.6.3 (instruções de instalação em http://docs.mongodb.org/manual/installation/)

---
#### Status
- [x] Sign in/Sign up com Devise
- [x] Tela de criação de listas
- [x] Tela de criação de tarefas via ajax
- [x] Tela de "Explorar", com as listas públicas de todos os usuários
- [x] Opção de marcar lista como favorita na tela de "Explorar" através do ícone de estrela
- [x] *** Testes com Rspec e Capybara: testes não estão com a cobertura ideal ainda e falham ao serem executados em lote (vide a nota na seção sobre os testes)
- [ ] Estilos das páginas do Devise
- [ ] Segurança: impedir que um usuário veja listas privadas de outros usuários através de manipulação direta de URL
- [ ] Flash messages em caso de operações mal-sucedidas

---
#### Execução dos testes automatizados
```
bundle exec rspec spec/models/ -fd
bundle exec rspec spec/features/sign_in_spec.rb -fd
bundle exec rspec spec/features/list_and_tasks_creation_spec.rb -fd
bundle exec rspec spec/features/mark_a_list_as_favorite_spec.rb -fd
```

Os últimos 2 testes são feitos utilizando-se o Selenium.

**NOTA:** deve-se executar os testes de features um de cada vez. (A execução em lote falha devido à ordem da execução dos scenarios).