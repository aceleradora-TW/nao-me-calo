require 'rails_helper'

feature 'Rate establishment', js: true do

  scenario 'rate 4 in woman' do
    visit '/avaliar?utf8=%E2%9C%93&commit=Avaliar&placeId=ChIJj2J3iGOCGZUR5XT38N2pANQ'
    find_by_id('rate_test').click
    page.execute_script 'window.scrollBy(0,500)'
    fill_in'nameEvaluate', :with => 'Jonatas'
    page.execute_script '$("#cpfEvaluate").val("01854323016")'
    fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
    page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
    page.execute_script '$("#dateEvaluate").val("10/06/2016")'
    fill_in 'ratingDescription', :with => 'Este é um texto de teste!'
    check 'terms'
    click_on 'Enviar avaliação'

    expect(page).to have_content 'Avaliação feita com sucesso'

  end

  scenario 'failed rating' do

    visit '/avaliar?utf8=%E2%9C%93&commit=Avaliar&placeId=ChIJj2J3iGOCGZUR5XT38N2pANQ'
    # find_by_id('rate_test').click
    page.execute_script 'window.scrollBy(0,500)'
    fill_in'nameEvaluate', :with => 'Jonatas'
    page.execute_script '$("#cpfEvaluate").val("01854323016")'
    fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
    page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
    page.execute_script '$("#dateEvaluate").val("10/06/2016")'
    fill_in 'ratingDescription', :with => 'Este é um texto de teste!'
    check 'terms'
    expect(page).to have_button('submitButton', disabled: true)


  end

end
