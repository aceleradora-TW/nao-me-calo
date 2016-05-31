require 'rails_helper'

RSpec.describe "ratings/index", type: :view do
  before(:each) do
    assign(:ratings, [
      Rating.create!(
        :woman => 1.5,
        :lgbtqia => 1.5,
        :black => 1.5,
        :disability => 1.5,
        :elder => 1.5,
        :obese => 1.5,
        :name => "Name",
        :cpf => "Cpf",
        :email => "Email",
        :phone => "Phone"
      ),
      Rating.create!(
        :woman => 1.5,
        :lgbtqia => 1.5,
        :black => 1.5,
        :disability => 1.5,
        :elder => 1.5,
        :obese => 1.5,
        :name => "Name",
        :cpf => "Cpf",
        :email => "Email",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of ratings" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Cpf".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
