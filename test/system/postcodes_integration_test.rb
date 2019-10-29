require 'application_system_test_case'

class PostcodesIntegrationTest < ApplicationSystemTestCase
  setup do
    VCR.insert_cassette('postcodes_io/lookup')
  end

  teardown do
    VCR.eject_cassette
  end

  test 'visiting the index should show the form' do
    visit postcodes_url

    assert_selector 'form input[type=text]', count: 1
    assert_selector 'form input[type=submit]', count: 1
  end

  test 'can fill and submit the form' do
    visit postcodes_url

    fill_in 'query', with: 'SW112NW'
    click_button 'Submit'
  end

  test 'can see the results after submiting the form' do
    visit postcodes_url

    assert_selector '#result', visible: false

    fill_in 'query', with: 'SW112NW'
    click_button 'Submit'

    assert_selector '#result', visible: true
  end

  test 'can see the success message after submiting the form' do
    visit postcodes_url

    fill_in 'query', with: 'SW112NW'
    click_button 'Submit'

    assert_selector '#result > .success', visible: true
  end

  test 'can see the error message after submiting the form' do
    visit postcodes_url

    assert_selector '#result', visible: false

    fill_in 'query', with: 'INVALIDPOSTCODE'
    click_button 'Submit'

    assert_selector '#result > .error', visible: true
  end
end
