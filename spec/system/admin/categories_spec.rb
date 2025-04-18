require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:admin) { FactoryBot.create(:admin) }
  let(:category) { FactoryBot.create(:category) }

  describe 'カテゴリー画面のテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_categories_path
    end

    describe '表示の確認' do
      it '「カテゴリー一覧・追加」と表示される' do
        expect(page).to have_content('カテゴリー一覧・追加') 
      end
    end

    describe 'カテゴリー作成' do
      context '入力内容が正しい時' do
        it 'カテゴリー作成に成功する' do
          fill_in 'category[name]', with: 'ランニング'
          expect do
            click_button 'カテゴリー追加'
          end.to change(Category, :count).by(1)
        end
      end

      # context 'フォームを空で送信した時' do
      #   it 'カテゴリー作成に失敗する' do
      #     fill_in 'category[name]', with: ''
      #     expect do
      #       click_button 'カテゴリー追加'
      #     end.to change(Category, :count).by(0)
      #   end
      # end
    end

    describe 'カテゴリー削除' do
      context 'カテゴリー削除ボタンを押した時' do
        it 'カテゴリーカウントが１減る' do
          expect do
            click_link '削除', match: :first
          end.to change(Category, :count).by(-1)
        end
      end
    end

  end


    describe 'カテゴリー編集画面のテスト' do
      before do
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
        visit edit_admin_category_path(category)
      end

      context '入力内容が正しい時' do
        it '編集に成功する' do
          fill_in 'category[name]', with: 'ウォーキング'
          click_button '変更を保存'
          expect(page).to have_content 'ウォーキング'
          expect(current_path).to eq admin_categories_path 
        end
      end

      context 'フォームを空で送信した時' do
        it '編集に失敗する' do
          fill_in 'group[name]', with: ''
          fill_in 'group[introduction]', with: ''
          click_button 'Update Group'
          expect(page).to have_content 'グループ名を入力してください'
          expect(page).to have_content 'グループ紹介を入力してください'
        end
      end



      context '表示の確認' do
        it '編集前の内容がフォームに表示されている' do
          expect(page).to have_select('group[category_id]', selected: '美容')
          expect(page).to have_field 'group[name]', with: group.name
          expect(page).to have_field 'group[introduction]', with: group.introduction
        end
        it '「Edit Group」と表示される' do
          expect(page).to have_content('Edit Group') 
        end
        it 'グループ編集ボタンが表示される' do
          expect(page).to have_button 'Update Group' 
        end
        it 'グループ削除ボタンが表示される' do
          expect(page).to have_link 'Delete Group'
        end
      end
    end
  end


