require 'rails_helper'

describe 'スペシャルモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(name: '', email: 'suzuki_test111@example.com', password: 'suzuki', password_confirmation: 'suzuki')
        expect(user).not_to be_valid
      end
    end

    context 'メールが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'suzuki_test111', email: '', password: 'suzuki', password_confirmation: 'suzuki')
        expect(user).not_to be_valid
      end
    end

    context 'パスワードが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'suzuki_test111', email: 'suzuki_test111@example.com', password: '', password_confirmation: 'suzuki')
        expect(user).not_to be_valid
      end
    end

    context 'パスワード（確認用）が空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'suzuki_test111', email: 'suzuki_test111@example.com', password: 'suzuki', password_confirmation: '')
        expect(user).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'suzuki_test111', email: 'suzuki_test111@example.com', password: 'suzuki', password_confirmation: 'suzuki')
        expect(user).to be_valid
      end
    end
  end
end
