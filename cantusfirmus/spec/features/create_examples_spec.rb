require 'rails_helper'

describe 'creating examples' do

  before(:each) do
    example = FactoryGirl.create(:example)
  end

  it 'generates a new example from examples' do
    visit '/examples/new'
    expect(page).to have_content "Examples"
  end

  it 'allows you to save a generated example' do
    visit '/examples/new'
    click_on 'Generate'
    expect(page).to have_content "Examples"
  end
end
