module SignInModule
  def sign_in_as(member)
    visit new_member_session_path
    fill_in "E-Mail", with: member.email
    fill_in "PassWord", with: member.password
    click_button "Log In"
  end
end