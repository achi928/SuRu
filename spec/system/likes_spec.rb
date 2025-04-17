require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:member) { FactoryBot.create(:member) }
  let(:group) { FactoryBot.create(:group) }
  let!(:membership) { FactoryBot.create(:membership, member: member, group: group) }
  let!(:post) { FactoryBot.create(:post, member: member, group: group) }

  describe '投稿のテスト' do
    before do 
      sign_in(member)
      visit group_path(group)
    end

    context '入力内容が正しい時' do
      it 'コメントに成功する' do
        fill_in 'comment[content]', with: 'お疲れ'
        expect do
          click_button 'Post a Comment'
        end
        .to change(Comment, :count).by(1)
        expect(current_path).to eq group_path(group) 
      end
    end

    context 'フォームを空で送信した時' do
      it 'コメントに失敗する' do
        fill_in 'comment[content]', with: ''
        expect do
          click_button 'Post a Comment'
        end.to change(Comment, :count).by(0)
      end
    end

    context '表示の確認' do
      it '「New Comment」と表示される' do
        expect(page).to have_content('New Comment') 
      end
    end

  end
end