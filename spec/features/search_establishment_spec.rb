require 'rails_helper'

feature 'Search establishment', js: true do

  scenario 'See establishment profile' do
    page.driver.browser.manage.window.resize_to(2560, 1600)
    visit '/'
    fill_in 'searchField', with: 'Bar do Beto'
    sleep 3
      page.all('.pac-item')[1].click
    click_on 'Buscar'
    expect(page).to have_content 'Bar do Beto'

    sleep 5

    visit '/'
    sleep 7
    end

end
