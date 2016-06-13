require "rails_helper"

feature "See tips" do
  scenario "Click button of tips" do
    visit '/'

    click_link 'Dicas'

    expect(page).to have_content 'Sofri discriminação: e agora?'
  end
end
