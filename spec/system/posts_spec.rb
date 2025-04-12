require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:member) { FactoryBot.create(:member) }
  let(:group) { FactoryBot.create(:group) }
  let!(:membership) { FactoryBot.create(:membership, member: member, group: group) }

  describe '投稿・編集のテスト' do

    before do 
      sign_in(member)
      visit group_path(group)
    end

    describe '投稿のテスト' do
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




  end
end