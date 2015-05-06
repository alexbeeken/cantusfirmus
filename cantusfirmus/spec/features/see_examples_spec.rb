require 'rails_helper'

describe "viewing examples" do

  before(:each) do
    @example = FactoryGirl.create(:example)
  end

  it 'shows all examples' do
    visit "/examples"
    expect(page).to have_content "#{@example.notes}"
  end

  # it 'shows an individual example' do
  #   example = FactoryGirl.create(:example)
  #   visit "/examples", example
  #   click_on example.notes
  #   expect(page).to have_content "Showing #{example.notes}"
  # end

end
