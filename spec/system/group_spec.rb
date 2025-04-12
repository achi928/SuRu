require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  let(:member) { FactoryBot.create(:member) }
  let(:member2) { FactoryBot.create(:member) }
  let(:group) { FactoryBot.create(:group, owner: member) }
  let!(:membership) { FactoryBot.create(:membership, member: member, group: group) }
  let!(:membership2) { FactoryBot.create(:membership, member: member2, group: group) }
  # let!(:category) { FactoryBot.create(:category) }

  describe 'グループ（information）画面' do
    context 'グループオーナーの場合' do
      before do
        sign_in(member)
        visit information_path(group)
      end

      it 'グループのオーナーが表示されている' do
        expect(page).to have_content group.owner.nickname
      end

      it '編集ボタンが表示される' do
        expect(page).to have_link 'Edit Group'
      end

    end

    context 'グループオーナー以外の場合' do
      before do
        sign_in(member2)
        visit information_path(group)
      end

      it '編集ボタンが表示されない' do
        expect(page).to have_no_button 'Edit Group'
      end

      it '削除ボタンが表示されない' do
        expect(page).to have_no_button 'Delete Group'
      end
    end
  end



  # describe 'グループ詳細画面のテスト' do
  #   before do
  #     visit group_path(group)
  #   end

  #   context '表示の確認' do
  #     # itブロックここに書く
  #   end
  # end

  describe 'グループ作成画面のテスト' do
    before do
      sign_in(member)
      visit new_group_path
    end

    context '入力内容が正しい時' do
      it 'グループ作成に成功する' do
        expect do
          select '美容', from: 'group[category_id]'
          fill_in 'group[name]', with: '毎日7時起き'
          fill_in 'group[introduction]', with: '毎日7時起きに起きます'
          click_button 'Create Group'
        end.to change(Group, :count).by(1)
      end
    end

    context 'フォームを空で送信した時' do
      it 'グループ作成に失敗する' do
        expect do
          fill_in 'group[name]', with: ''
          fill_in 'group[introduction]', with: ''
          click_button 'Create Group'
        end.to change(Group, :count).by(0)
      end
    end

    context '表示の確認' do
      it '「New Group」と表示される' do
        expect(page).to have_content('New Group') 
      end

      it 'グループ作成ボタンが表示される' do
        expect(page).to have_button 'Create Group' 
      end
    end
  end

  describe 'グループ編集画面のテスト' do
    before do
      sign_in(member)
      visit edit_group_path(group)
    end

    context '表示の確認' do
      it '「Edit Group」と表示される' do
        expect(page).to have_content('Edit Group') 
      end

      it 'グループ編集ボタンが表示される' do
        expect(page).to have_button 'Update Group' 
      end
    end
  end
end


