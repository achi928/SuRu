require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '投稿のテスト' do

    let(:group) { FactoryBot.create(:group) }
    describe 'トップ画面(root_path)のテスト' do
      before do 
        visit group_path(group)
      end
      context '表示の確認' do
        # it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        #   expect(page).to have_link "", href: books_path
        # end
        # it 'root_pathが"/"であるか' do
        #   expect(current_path).to eq('/')
        # end
      end
    end
  end
end