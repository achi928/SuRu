require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '投稿・編集のテスト' do
    let(:group) { FactoryBot.create(:group) }

    before do 
      visit group_path(group)
    end

    describe '投稿のテスト' do
      context '入力内容が正しい時' do
        it '投稿に成功する' do
          fill_in 'new_post', with: Faker::Lorem.sentence
          click_button 'Create Post'
          expect(page).to have_content '投稿しました!'
        end
      end

      context 'フォームを空で送信した時' do
        it '投稿に失敗する' do
          fill_in 'post[content]', with: ''
          click_button 'Create Post'
          expect(page).to have_content '投稿に失敗しました'
        end
      end
    end




  end
end