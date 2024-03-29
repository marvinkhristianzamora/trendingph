include ApplicationHelper

def valid_signin(user)
  visit signin_path
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_success_alert do |message|
  match do |page|
    expect(page).to have_selector('span.short-alert.short-alert-success', text: message)
  end
end
