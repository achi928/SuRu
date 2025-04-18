require 'rails_helper'

RSpec.describe 'Members', type: :system do
  let(:member) { FactoryBot.create(:member) }

  describe 'ログインのテスト' do
    context 'グループに未所属の時' do
      it 'カテゴリ一覧に遷移する' do
        sign_in(member)
        expect(page).to have_content 'ログインしました！'
        expect(current_path).to eq categories_path
      end
    end

    context 'グループに所属していた時' do
      let(:group) { FactoryBot.create(:group) }
      let!(:membership) { FactoryBot.create(:membership, member: member, group: group) }
      it 'マイページへ遷移する' do
        sign_in(member)
        expect(current_path).to eq mypage_path
      end
    end
  end

  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
          visit new_member_registration_path
      end
      context '入力内容が正しい時' do
        it '新規登録に成功する' do
          fill_in 'member[nickname]', with: Faker::Internet.username(specifier: 5)
          fill_in 'member[email]', with: Faker::Internet.email
          fill_in 'member[password]', with: '111111'
          fill_in 'member[password_confirmation]', with: '111111'
          click_button 'Sign Up'
          expect(page).to have_content 'アカウント登録が完了しました。気になるCategoryから自分にぴったりのGroupを見つけよう！'
        end
        
      context '入力内容に不備がある時'
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

end

