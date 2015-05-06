require 'rails_helper'

describe 'creating examples' do

  before(:each) do
    example = FactoryGirl.create(:example)
  end

  it 'generates a new example from examples' do
    visit '/examples/new'
    expect(page).to have_content "Examples"
  end

end
