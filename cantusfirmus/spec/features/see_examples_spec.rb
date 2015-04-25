require 'rails_helper'

describe "viewing examples" do

  it 'shows all examples' do
    example = FactoryGirl.create(:example)
    visit "/examples"
    expect(page).to have_content "#{example.notes}"
  end

  it 'shows an individual example' do
    example = FactoryGirl.create(:example)
    visit "/examples"
    click_on example.notes
    expect(page).to have_content "Showing #{example.notes}"
  end

end
