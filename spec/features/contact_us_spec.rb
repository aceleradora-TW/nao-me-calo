require "rails_helper"
feature "Send email" do # , :js => true do
  scenario "Fill all fields and send" do
    visit '/faleconosco'
    fill_in 'name', :with => 'John'
    fill_in 'email', :with => 'john@gmail.com'
    fill_in 'subject', :with => 'Some subject'
    fill_in 'message', :with => 'Some mesage'
    click_on 'Enviar!'
    expect(page).to have_content 'Mensagem enviada com sucesso!'
  end
end
