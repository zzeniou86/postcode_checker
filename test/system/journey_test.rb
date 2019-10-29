require 'application_system_test_case'

class JourneyTest < ApplicationSystemTestCase
  setup do
    VCR.insert_cassette('postcodes_io/lookup')
  end

  teardown do
    VCR.eject_cassette
  end

  test 'When I fill the form with a servicable postcode, then the page should show tell me the postcode is whitelisted' do
    visit postcodes_url

    assert_text 'Enter a postcode:'
    fill_in 'query', with: 'SE1 7QD'
    click_button 'Submit'
    assert_text 'The postcode is whitelisted'
  end

  test 'When I fill the form with a non-serviceable postcode, then the page should tell me the postcode is not whitelisted' do
    visit postcodes_url

    assert_text 'Enter a postcode:'
    fill_in 'query', with: 'SW11 2NW'
    click_button 'Submit'
    assert_text 'The postcode is not whitelisted'
  end

  test 'When I fill the form with a bad formatted postcode, then the page should give me an error about it' do
    visit postcodes_url

    assert_text 'Enter a postcode:'
    fill_in 'query', with: 'INVALIDPOSTCODE'
    click_button 'Submit'
    assert_text 'The postcode format is invalid. Please check if it\'s correct and try again'
  end

  test 'When I fill the form with a non-existing postcode, then the page should give me an error about it' do
    visit postcodes_url

    assert_text 'Enter a postcode:'
    fill_in 'query', with: 'SW11 2NF'
    click_button 'Submit'
    assert_text 'Postcode not found'
  end
end
