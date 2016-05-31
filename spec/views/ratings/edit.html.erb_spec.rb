require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  before(:each) do
    @rating = assign(:rating, Rating.create!(
      :woman => 1.5,
      :lgbtqia => 1.5,
      :black => 1.5,
      :disability => 1.5,
      :elder => 1.5,
      :obese => 1.5,
      :name => "MyString",
      :cpf => "MyString",
      :email => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders the edit rating form" do
    render

    assert_select "form[action=?][method=?]", rating_path(@rating), "post" do

      assert_select "input#rating_woman[name=?]", "rating[woman]"

      assert_select "input#rating_lgbtqia[name=?]", "rating[lgbtqia]"

      assert_select "input#rating_black[name=?]", "rating[black]"

      assert_select "input#rating_disability[name=?]", "rating[disability]"

      assert_select "input#rating_elder[name=?]", "rating[elder]"

      assert_select "input#rating_obese[name=?]", "rating[obese]"

      assert_select "input#rating_name[name=?]", "rating[name]"

      assert_select "input#rating_cpf[name=?]", "rating[cpf]"

      assert_select "input#rating_email[name=?]", "rating[email]"

      assert_select "input#rating_phone[name=?]", "rating[phone]"
    end
  end
end
