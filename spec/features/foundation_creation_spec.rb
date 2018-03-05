require 'rails_helper'

feature 'In order to hold community funds securely' do
  include AuthenticationHelpers

  background do
    @user = a_signed_in_user
  end

  scenario 'A donor creates a foundation proposal and deploys it to the Ethereum blockchain' do
    Given 'a donor on the landing page'
    When 'they click the create foundation button'
    And 'the donor submits the form with foundation parameters'
    Then 'the donor sees a page to set up the initial pledge'

    When 'the donor submits the initial foundation pledge'
    Then 'they see a summary of their pledge'

    When 'the donor views the foundation page'
    Then 'they see a status page for the foundation with key stats'
    And 'they see their name and join date on the funders list'
  end

  def a_donor_on_the_landing_page
    visit root_path
  end

  def they_click_the_create_foundation_button
    click_on 'create-foundation'
  end

  def the_donor_submits_the_form_with_foundation_parameters
    select 'United States', from: 'foundation_country_alpha2'
    fill_in 'Local currency', with: 'USD'
    fill_in 'Postal code', with: '11206'
    fill_in 'Minimum participants', with: 100
    fill_in 'Minimum starting funds', with: 10000
    fill_in 'Activation deadline', with: 30.days.from_now.strftime('%e %B, %Y')
    click_on 'create'
  end

  def the_donor_sees_a_page_to_set_up_the_initial_pledge
    expect(page).to have_content 'Initial Pledge'
    expect(page).to have_field('pledge_foundation', disabled: true)
    expect(page).to have_field('pledge_currency', disabled: true)
    expect(page).to have_field('initial_gas', disabled: true)
  end

  def the_donor_submits_the_initial_foundation_pledge
    fill_in 'pledge_amount', with: 50
    fill_in 'bank_account', with: 111111111
    fill_in 'bank_routing', with: 999999999
    click_on 'submit-pledge'
  end

  def they_see_a_summary_of_their_pledge
    expect(page).to have_content 'Initial Pledge'
    within('#initial-gas') do
      expect(page).to have_content '50.00'
    end
    within('#pledge-amount') do
      expect(page).to have_content '50.00'
    end
    within('#activation-amount') do
      expect(page).to have_content '100.00'
    end
    within('#monthly-amount') do
      expect(page).to have_content '50.00'
    end
  end

  def the_donor_views_the_foundation_page
    click_on 'view-foundation'
  end

  def they_see_a_status_page_for_the_foundation_with_key_stats
    @foundation = Foundation.last
    expect(page).to have_content "Community Foundation of Bushwick (11206)"
    expect(page).to have_content @foundation.address
    expect(page).to have_content "10,000.00 USD required in order to activate"
    expect(page).to have_content "100 funders required in order to activate"
    within('#status') do
      expect(page).to have_content "Pending"
    end
    within('#pledges-total') do
      expect(page).to have_content @foundation.pledge_total
    end
    within('#funders-total') do
      expect(page).to have_content @foundation.pledges.count
    end
    expect(page).to have_content @foundation.activation_deadline.strftime('%e %B, %Y')
    expect(page).to have_content @foundation.latitude
    expect(page).to have_content @foundation.longitude
  end

  def they_see_their_name_and_join_date_on_the_funders_list
    within('#funders') do
      expect(page).to have_content(@user.full_name)
      expect(page).to have_content(@foundation.pledges.first.created_at.strftime('%e %B, %Y'))
    end
  end

end
