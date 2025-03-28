require 'rails_helper'
#sign_in_as(member) サインインの状態を作る

RSpec.describe "Members", type: :system do

  scenario "log in" do
    member = FactoryBot.create(:member)
    expect {
      sign_in_as(member)

      expect(page).to have_content "ログインしました！"
    }
  end

  scenario "Sing up" do
    
  end
end


describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
      before do
          visit new_member_registration_path
      end
      context '新規登録画面に遷移' do
          it '新規登録に成功する' do
              fill_in 'member[nickname]', with: Faker::Internet.username(specifier: 5)
              fill_in 'member[email]', with: Faker::Internet.email
              fill_in 'member[password]', with: '111111'
              fill_in 'member[password_confirmation]', with: '111111'
              click_button 'Sign Up'
              expect(page).to have_current_path categories_path
          end
          
          it '新規登録に失敗する' do
              fill_in 'member[nickname]', with: ''
              fill_in 'member[email]', with:''
              fill_in 'member[password]', with:''
              fill_in 'member[password_confirmation]', with:''
              click_button 'Sign Up'

              expect(page).to have_content 'メールアドレスを入力してください'
              expect(page).to have_content 'パスワードを入力してください'
              expect(page).to have_content 'ニックネームを入力してください'
          end
      end
  end
end