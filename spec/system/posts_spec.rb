require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:member) { FactoryBot.create(:member) }
  let(:group) { FactoryBot.create(:group) }
  let!(:membership) { FactoryBot.create(:membership, member: member, group: group) }
  let!(:post) { FactoryBot.create(:post, member: member) }

  describe '投稿・編集のテスト' do

    describe '投稿のテスト' do
      before do 
        sign_in(member)
        visit group_path(group)
      end

      context '入力内容が正しい時' do
        it '投稿に成功する' do
          expect do
            fill_in 'post[content]', with: 'おはよう'
            click_button 'Create Post'
          end.to change(Post, :count).by(1)
        end
      end

      context 'フォームを空で送信した時' do
        it '投稿に失敗する' do
          expect do
            fill_in 'post[content]', with: ''
            click_button 'Create Post'
          end.to change(Post, :count).by(0)
        end
      end
      
    end
    

    describe '編集のテスト' do
      before do 
        sign_in(member)
        visit edit_group_post_path(group,post)
      end

      context '入力内容が正しい時' do
        it '編集に成功する' do
          fill_in 'post[content]', with: 'おやすみ'
          click_button 'Update Post'
          expect(current_path).to eq group_path(group) 
        end
      end

      context 'フォームを空で送信した時' do
        it '編集に失敗する' do
          fill_in 'post[content]', with: ''
          click_button 'Update Post'
          expect(page).to have_content '内容を入力してください'
        end
      end

      context '表示の確認' do
        it '編集前の内容がフォームに表示されている' do
          expect(page).to have_field 'post[content]', with: post.content
        end
        it 'Update ボタンが表示される' do
          expect(page).to have_button 'Update Post'
        end
      end

    end
  end
end