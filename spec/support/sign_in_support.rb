module SignInSupport
  def sign_in(member)
    visit new_member_session_path
    fill_in "E-Mail", with: member.email
    fill_in "PassWord", with: member.password
    click_button "Log In"
  end

  def setup_current_member
    let(:member) { FactoryBot.create(:member) }
    let(:group) { FactoryBot.create(:group) }
    let(:membership) { FactoryBot.create(:membership, member: member, group: group) }
  end
end