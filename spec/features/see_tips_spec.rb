require "rails_helper"

feature "See tips", js: true do
  scenario "Click button of tips" do
    visit '/'

    click_link 'Dicas'

    expect(page).to have_content 'Sofri discriminação: e agora?'
    sleep 5

  end
end
