require "rails_helper"
feature "Send email" do # , :js => true do
  scenario "Fill all fields and send" do
    visit '/faleconosco'
    fill_in 'name', :with => 'John'
    fill_in 'email', :with => 'john@gmail.com'
    fill_in 'subject', :with => 'Some subject'
    fill_in 'message', :with => 'Some mesage'
    click_on 'Enviar'
    expect(page).to have_content 'Mensagem enviada com sucesso!'
  end

  scenario "invalid email" do
    visit '/faleconosco'
    fill_in 'name', :with => 'John'
    fill_in 'email', :with => 'johngmail.com'
    fill_in 'subject', :with => 'Some subject'
    fill_in 'message', :with => 'Some mesage'
    expect(page).to have_content 'Por favor, digite um e-mail válido.'
  end

  scenario "message with ofensive words" do
    visit '/faleconosco'
    fill_in 'name', :with => 'John'
    fill_in 'email', :with => 'john@gmail.com'
    fill_in 'subject', :with => 'Some subject'
    fill_in 'message', :with => 'merda'
    expect(page).to have_content 'Seu texto contém palavras ofensivas, por favor corrija'
  end

  scenario "invalid name" do
    visit '/faleconosco'
    fill_in 'name', :with => '1John'
    fill_in 'email', :with => 'john@gmail.com'
    fill_in 'subject', :with => 'Some subject'
    fill_in 'message', :with => 'merda'
    expect(page).to have_content 'Por favor, digite um nome válido.'
  end


end
