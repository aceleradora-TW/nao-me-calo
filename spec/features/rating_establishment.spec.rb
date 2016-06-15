require 'rails_helper'
feature 'Rate establishment', js: true do

  background do

  end

  scenario 'Search Beco 203 and rate 4 in woman' do
    visit '/'
    fill_in 'evaluateField', with: 'Beco 203'
    sleep 5
    first('.pac-item').click
    click_on 'Avaliar'

    expect(page).to have_content 'Beco 203'
  end

end
