require 'rails_helper'

RSpec.describe Establishment, type: :model do
  it 'expect to populate rate result with ratings and pessimo' do
    expect(populate_rate_array(@ratings1)).to eq([[@r1, "Péssimo"], [@r1, "Péssimo"]])
  end

  it 'expect to populate rate result with rating and regular' do
    expect(populate_rate_array(@ratings3)).to eq([[@r3, "Regular"], [@r3, "Regular"]])
  end

  it 'expect to populate with rating and otimo' do
    expect(populate_rate_array(@ratings5)).to eq([[@r5, "Ótimo"], [@r5, "Ótimo"]])
  end
end
