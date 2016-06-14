require 'rails_helper'

feature 'Rate establishment', js: true do

  scenario 'Search Bar do Beto and rate 4 in woman' do
    page.driver.browser.manage.window.resize_to(2560, 1600)
    visit '/'
    fill_in 'evaluateField', with: 'Bar do Beto  '
    sleep 3
    page.all('.pac-item')[1].click
    click_on 'Avaliar'
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

    sleep 5

    visit '/'
    sleep 5

    fill_in 'searchField', with: 'Bar do Beto'
    sleep 3
    page.all('.pac-item')[1].click
    click_on 'Buscar'

    sleep 5

    visit '/'
    sleep 7
    end
end
