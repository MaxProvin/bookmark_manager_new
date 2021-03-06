feature "signing up" do
  scenario "user signs up" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome batman@gmail.com!"
    expect(User.first.email).to eq('batman@gmail.com')

  end

  scenario 'password confirmation on sign up' do
    expect { sign_up_wrong }.to change(User, :count).by(0)
    expect(page).not_to have_content "Hello batman@gmail.com!"
  end

  scenario 'failed password confirmation doesn\'t redirect page' do
    sign_up_wrong
    expect(page).to have_content "Password:"
    expect(page).to have_content "Password does not match the confirmation"
  end

  scenario 'user can\'t sign in without inputting an email address' do
    no_email
    expect(current_path).to eq('/users')
    expect(page).to have_content "Email must not be blank"
  end

  scenario 'user can\t sign up with an invalid email address' do
    wrong_email
    expect(current_path).to eq('/users')
    expect(page).to have_content "Email has an invalid format"
  end

  scenario 'user can\'t sign up with an already registered email address' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end

end
