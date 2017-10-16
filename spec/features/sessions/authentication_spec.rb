require 'rails_helper'
feature 'authentication feature' do
    before do
        @user = create(:user)
      end
  feature "user attempts to sign-in" do
    scenario 'visits sign-in page, prompted with email and password fields' do
        visit '/sessions/new'
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
    end
        
    scenario 'logs in user if email/password combination is valid' do
        visit '/sessions/new'
        fill_in 'email', with: "oscar@gmail.com"
        fill_in 'password', with: "password"
        click_button 'Log In'
        expect(page).to have_current_path("/users/#{@user.id}")
        expect(page).to have_content("Oscar Vazquez")
    end

    scenario 'does not sign in user if email is not found' do
        log_in email: "aa@email"
        expect(page).to have_current_path("/sessions/new")
        expect(page).to have_content("Can't find this email")

    end

    scenario 'does not sign in user if email/password combination is invalid' do 
        log_in email: "oscar@gmail.com", password: "wrongpassword"
        expect(page).to have_current_path("/sessions/new")
        expect(page).to have_content("Incorrect password")
    end
  end

  feature "user attempts to log out" do
    before(:each) do
        log_in
    end
    scenario 'displays "Log Out" button when user is logged on' do
        expect(page).to have_button("Log Out")
    end

    scenario 'logs out user and redirects to login page' do
        click_button 'Log Out'
        expect(page).to have_current_path("/sessions/new")
    end
  end
end