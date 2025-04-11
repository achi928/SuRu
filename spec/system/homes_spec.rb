require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  describe 'トップ画面(root_path)のテスト' do
    before do 
      visit root_path
    end
    context '表示、リンクの確認' do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it 'ログインボタンのリンク先が正しいか' do
        click_link 'Log In', match: :first
        visit new_member_session_path
      end
      it '新規登録ボタンのリンク先が正しいか' do
        click_link 'Sign Up', match: :first
        visit new_member_registration_path
      end
    end
  end
end