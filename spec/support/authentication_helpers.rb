module AuthenticationHelpers

  def a_signed_in_user
    FactoryGirl.create(
      :user
    ).tap do |user|
      visit root_path
      sign_in_as(user)
    end
  end

  def sign_in_as(user)
    visit root_path
    if page.has_selector?('#user-menu')
      page.find('#user-menu').click
      page.find('#sign-out').click
    end
    page.find('#sign-in').click
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end
end

