require 'rails_helper'

RSpec.describe Post, 'Postモデルのテスト',type: :model do
  describe '保存(create)ができるかのテスト' do
    it '正しい内容ならバリデーションが通ること' do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  describe 'Postモデルのバリデーション' do
    let(:post) { FactoryBot.build(:post) }
    #post = FactoryBot.build(:post)

    it '空欄のときエラーメッセージが表示されること' do
      post.content = ''
      expect(post).to be_invalid
      expect(post.errors[:content]).to include('を入力してください')
    end
    
  end
end
  
