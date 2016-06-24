require 'rails_helper'

feature 'See tags in rate page', js: true do

  background do
    @establishment = Establishment.create(name: 'Beco', address: 'Rua da Esperança, 800', lat: 0, lng: 0, id_places: 'ChIJj2J3iGOCGZUR5XT38N2pANQ')
    @rating_a = Rating.create(id: 1, woman: 5.0, lgbtqia: nil, race: 3.0, disability: nil, elder: nil, obese: nil, name: "mi", cpf: '444.444.444-44', email: '', phone: '', rating_date: Date.new)
    @rating_b = Rating.create(id: 2, woman: 5.0, lgbtqia: nil, race: 3.0, disability: nil, elder: nil, obese: nil, name: "mi", cpf: '444.444.444-44', email: '', phone: '', rating_date: Date.new)
    @establishment.ratings << [@rating_a, @rating_b]
  end

  scenario 'See tags' do
    visit '/avaliar?commit=Avaliar&place_id=ChIJj2J3iGOCGZUR5XT38N2pANQ'

    expect(page).to have_content 'Mulher'
    expect(page).to have_content 'Péssimo'
    expect(page).to have_content 'Ruim'
    expect(page).to have_content 'Regular'
    expect(page).to have_content 'Bom'
    expect(page).to have_content 'Ótimo'


    expect(page).to have_content 'Pessoa com deficiência'

  end

end
