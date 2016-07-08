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
   sleep 5
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
   sleep 5
 end

 scenario 'rating with ofensive words' do
   visit '/avaliar?utf8=%E2%9C%93&commit=Avaliar&placeId=ChIJj2J3iGOCGZUR5XT38N2pANQ'
   find_by_id('rate_test').click
   page.execute_script 'window.scrollBy(0,500)'
   fill_in'nameEvaluate', :with => 'Jonatas'
   page.execute_script '$("#cpfEvaluate").val("01854323016")'
   fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
   page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
   page.execute_script '$("#dateEvaluate").val("10/06/2016")'
   fill_in 'ratingDescription', :with => 'merda'
   check 'terms'
   expect(page).to have_button('submitButton', disabled: true)
   expect(page).to have_content 'Seu texto contém palavras ofensivas, por favor corrija'
   sleep 5
 end

 scenario 'filling cpf field with invalid' do
   visit '/avaliar?utf8=%E2%9C%93&commit=Avaliar&placeId=ChIJj2J3iGOCGZUR5XT38N2pANQ'
   find_by_id('rate_test').click
   sleep 3
   page.execute_script 'window.scrollBy(0,500)'
   fill_in'nameEvaluate', :with => 'Jonatas'
   fill_in 'cpfEvaluate', :with => '11111111111'
   fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
   page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
   page.execute_script '$("#dateEvaluate").val("10/06/2016")'
   fill_in 'ratingDescription', :with => 'merda'
   check 'terms'
   expect(page).to have_button('submitButton', disabled: true)
   expect(page).to have_content 'Por favor, digite um CPF válido'
   sleep 5
 end

 scenario 'rating wrongDate' do
   visit '/avaliar?utf8=%E2%9C%93&commit=Avaliar&placeId=ChIJj2J3iGOCGZUR5XT38N2pANQ'
   find_by_id('rate_test').click
   page.execute_script 'window.scrollBy(0,500)'
   fill_in'nameEvaluate', :with => 'Jonatas'
   page.execute_script '$("#cpfEvaluate").val("01854323016")'
   fill_in 'emailEvaluate', :with => 'jonatas@terra.com.br'
   page.execute_script '$("#phoneEvaluate").val("(51)33306088")'
   page.execute_script '$("#dateEvaluate").val("10/06/2011")'
   fill_in 'ratingDescription', :with => 'merda'
   check 'terms'
   expect(page).to have_button('submitButton', disabled: true)
   expect(page).to have_content 'Seu texto contém palavras ofensivas, por favor corrija'
   sleep 5
 end


end
