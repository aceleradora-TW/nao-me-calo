require 'rails_helper'

feature 'Rate establishment', js: true do

  scenario 'Search Beco 203 and rate 4 in woman' do
    page.driver.browser.manage.window.resize_to(2560, 1600)
    visit '/'
    fill_in 'evaluateField', with: 'Bar do Beto  '
    sleep 3
    page.all('.pac-item')[1].click
    click_on 'Avaliar'
    expect(page).to have_content 'Bar do Beto'
    choose 'rating_woman_4'
    page.execute_script 'window.scrollBy(0,500)'
    fill_in'rating_name', :with => 'Jonatas'
    page.execute_script '$("#cpfEvaluate").val("01854323016")'
    fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
    page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
    page.execute_script '$("#dateEvaluate").val("10/06/2016")'
    check 'terms'
    sleep 3
    click_on 'Enviar avaliação'
    expect(page).to have_content 'Bar do Beto'

    sleep 5

    visit '/'
    sleep 5


    end
end
