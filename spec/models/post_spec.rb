require 'rails_helper'

RSpec.describe Post, 'Postモデルのテスト',type: :model do
  describe '保存(create)ができるかのテスト' do
    it '正しい内容ならバリデーションが通ること' do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  describe 'Postモデルのバリデーション' do
    let(:post) { build(:post) }
  
    context 'contentカラム' do
      it '空欄のときエラーメッセージが表示されること' do
        post.content = ''
        expect(post).to be_invalid
        post.valid?
        expect(post.errors[:content]).to include("を入力してください")
      end
    end
  end
end
  
