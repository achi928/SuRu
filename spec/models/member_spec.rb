require 'rails_helper'

RSpec.describe Member, 'Memberモデルのテスト',type: :model do
  context '保存(create)ができるかのテスト' do
    it '正しい内容ならバリデーションが通ること' do
      expect(FactoryBot.build(:member)).to be_valid
    end
  end

  context '新規登録の時のテスト' do
    let(:member) { FactoryBot.build(:member) }
    it '登録後、is_activeがtrueであること' do
      expect(member.is_active).to eq true
    end

    it '登録後、genderがunspecifiedであること' do
      expect(member.gender).to eq 'unspecified'
    end
  end
  
end