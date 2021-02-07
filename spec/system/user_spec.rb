require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  before do
    FactoryBot.create(:special)
    FactoryBot.create(:second_special)
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザ新規登録' do
      it 'トップページへアクセスで、「詳細ページへ」のリンクがある' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'suzuki_test111'
        fill_in 'user_email', with: 'suzuki_test111@example.com'
        fill_in 'user_password', with: 'suzuki'
        fill_in 'user_password_confirmation', with: 'suzuki'
        click_on 'アカウント登録'
        expect(page).to have_content '詳細ページへ'
      end
    end
  end

  describe 'ログアウトのテスト' do
    context 'ログアウトした場合' do
      it "トップページへアクセスで、「詳細ページへ」のリンクがない" do
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test02@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        visit specials_path
        click_link "ログアウト"
        expect(page).not_to have_content '詳細ページへ'
      end
    end
  end

  describe "会員情報変更のテスト" do
    context "会員情報を変更した場合" do
      it "名前が変更される" do
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test01@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        visit edit_user_registration_path
        fill_in 'user_name', with: '鈴木一一'
        fill_in 'user_current_password', with: 'suzuki'
        click_on '更新'
        expect(page).to have_content '鈴木一一'
      end
    end
  end

  describe "ユーザー削除のテスト" do
    context "ユーザー削除をした場合" do
      it "ユーザーが削除される" do
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test01@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        visit edit_user_registration_path
        click_on 'アカウント削除'
        expect(page.accept_confirm).to eq "本当によろしいですか？"
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end
  end
end
