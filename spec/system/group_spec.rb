require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  let(:group) { FactoryBot.create(:group) }

  describe 'information画面のテスト' do
    before do
      visit information_path(group)
    end
      
    context '表示の確認' do
      it 'グループのオーナーが表示されている' do
        expect(page).to have_content group.owner.nickname 
      end

      it 'グループオーナーのみグループの編集ボタンが表示される' do
        # 実装ここに書く
      end

      it 'グループオーナー以外にグループの編集ボタンが表示されない' do
        # 実装ここに書く
      end

      it 'グループオーナーのみグループの削除ボタンが表示される' do
        # 実装ここに書く
      end

      it 'グループオーナー以外にグループの削除ボタンが表示されない' do
        # 実装ここに書く
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
      visit new_group_path
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
