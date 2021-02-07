require 'rails_helper'

describe 'スペシャルモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '製品名が空の場合' do
      it 'バリデーションにひっかる' do
        special = Special.new(product: '', company: '会社名１１', detail: '製品名１１の解説文', per: '16.1', status: '並', price: '220000')
        expect(special).not_to be_valid
      end
    end

    context '会社名が空の場合' do
      it 'バリデーションにひっかかる' do
        special = Special.new(product: '製品名１１', company: '', detail: '製品名１１の解説文', per: '16.1', status: '並', price: '220000')
        expect(special).not_to be_valid
      end
    end

    context '優待解説が空の場合' do
      it 'バリデーションにひっかかる' do
        special = Special.new(product: '製品名１１', company: '会社名１１', detail: '', per: '16.1', status: '並', price: '220000')
        expect(special).not_to be_valid
      end
    end

    context 'PERが空の場合' do
      it 'バリデーションにひっかかる' do
        special = Special.new(product: '製品名１１', company: '会社名１１', detail: '製品名１１の解説文', per: '', status: '並', price: '220000')
        expect(special).not_to be_valid
      end
    end

    context 'ステータスが空の場合' do
      it 'バリデーションにひっかかる' do
        special = Special.new(product: '製品名１１', company: '会社名１１', detail: '製品名１１の解説文', per: '16.1', status: '', price: '220000')
        expect(special).not_to be_valid
      end
    end

    context '取得価格が空の場合' do
      it 'バリデーションにひっかかる' do
        special = Special.new(product: '製品名１１', company: '会社名１１', detail: '製品名１１の解説文', per: '16.1', status: '並', price: '')
        expect(special).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # user = FactoryBot.create(:user, name: 'suzuki_test101', email: 'suzuki_test101@example.com', password: 'suzuki', password_confirmation: 'suzuki', admin: true)
        special = Special.new(product: '製品名１１', company: '会社名１１', detail: '製品名１１の解説文', per: '16.1', status: '並', price: '220000')
        expect(special).to be_valid
      end
    end
  end
end
