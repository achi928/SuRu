require 'rails_helper'

RSpec.describe Membership, 'Membershipモデルのテスト',type: :model do

  context 'グループ加入のテスト' do
    let(:membership) { FactoryBot.build(:membership) }
    it '加入後、is_activeがtrueであること' do
      expect(membership.is_active).to eq true
    end
  end
  
end