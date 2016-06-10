require 'rails_helper'

feature 'Rate establishment', js: true do

  scenario 'Search Beco 203 and rate 4 in woman' do
    page.driver.browser.manage.window.resize_to(2560, 1600)
    visit '/'
    fill_in 'evaluateField', with: 'Beco 203'
    sleep 3
    first('.pac-item').click
    click_on 'Avaliar'
    expect(page).to have_content 'Beco 203'
    choose 'rating_woman_4'
    page.execute_script 'window.scrollBy(0,500)'
    fill_in'rating_name', :with => 'Jonatas'
    page.execute_script '$("#cpfEvaluate").val("01854323016")'
    fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
    page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
    page.execute_script '$("#dateEvaluate").val("10/06/2016")'


    sleep 10

  end

end
