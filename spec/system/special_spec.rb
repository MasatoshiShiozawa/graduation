require 'rails_helper'

#ログインなしの場合の確認

RSpec.describe 'ログインなしでの閲覧', type: :system do
  before do
    FactoryBot.create(:special)
    FactoryBot.create(:second_special)
    FactoryBot.create(:category)
  end

  describe 'トップページへアクセス' do
    context 'トップページへアクセスした場合' do
      it '一覧が表示される' do
        visit specials_path
        expect(page).to have_content '製品名１'
      end
    end
  end

  describe 'トップページへアクセス' do
    context 'トップページへアクセスした場合' do
      it '詳細ページへのリンクが表示されない' do
        visit specials_path
        expect(page).not_to have_content '詳細ページへ'
      end
    end
  end

  describe 'トップページへアクセス' do
    context 'トップページへアクセスした場合' do
      it 'カテゴリーはリンクがない' do
        visit specials_path
        expect(page).not_to have_link '金券'
      end
    end
  end

  describe '詳細ページへアクセス' do
    context '詳細ページへアクセスした場合' do
      it 'アクセスできない' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).to have_content 'PER低い順でソート'
      end
    end
  end

end

#ログインありの場合の確認

RSpec.describe '管理者以外の者がログインして閲覧', type: :system do
  before do
    FactoryBot.create(:special)
    FactoryBot.create(:second_special)
    FactoryBot.create(:category)
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
    visit new_user_session_path
    fill_in 'Eメール', with: 'suzuki_test01@example.com'
    fill_in 'パスワード', with:'suzuki'
    click_on 'ログインする'
  end

  describe 'トップページへアクセス' do
    context 'トップページへアクセスした場合' do
      it '一覧が表示される' do
        visit specials_path
        expect(page).to have_content '製品名１'
      end
    end
    context 'トップページへアクセスした場合' do
      it '詳細ページへが表示される' do
        visit specials_path
        expect(page).to have_content '詳細ページへ'
      end
    end
    context 'トップページへアクセスした場合' do
      it '新しく優待を投稿するのリンクが表示されない' do
        visit specials_path
        expect(page).not_to have_content '新しく優待を投稿する'
      end
    end
    context 'トップページへアクセスした場合' do
      it 'カテゴリーはリンクがある' do
        visit specials_path
        expect(page).to have_link '金券'
      end
    end
    context 'トップページへアクセスした場合' do
      it '▼PER低い順でソートを押すと、PER低い順でソートされる' do
        visit specials_path
        click_link '▼PER低い順でソート'
        expect(Special.order("per ASC").map(&:product)).to eq ["製品名２", "製品名１"]
      end
    end
    context 'トップページへアクセスした場合' do
      it '▼取得価格順にソートを押すと、取得価格の低い順でソートされる' do
        visit specials_path
        click_link '▼取得価格順にソート'
        expect(Special.order("price ASC").map(&:product)).to eq ["製品名２", "製品名１"]
      end
    end
  end

  describe '詳細ページへアクセス' do
    context '詳細ページへアクセスした場合' do
      it '詳細ページが表示される' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).to have_content '解説'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '優待編集のリンクが表示されない' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).not_to have_content '編集する'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '優待削除のリンクが表示されない' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).not_to have_content '削除する'
      end
    end
    context '詳細ページへアクセスした場合' do
      it 'コメントが登録できる', js: true do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        # visit @special_comment
        # xhr :@special, special_comments_path, comment: { message: "hello" }
        # binding.irb
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは編集リンクがある' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_link 'コメント編集'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは編集できる' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        click_link 'コメント編集'
        click_button '更新する'
        expect(page).to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは削除リンクがある' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_link 'コメント削除'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは削除できる' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        click_link 'コメント削除'
        expect(page.accept_confirm).to eq "本当に削除しますか?"
        expect(page).not_to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分以外が書いたコメントは編集リンクがない' do
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test02@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello2'
        click_button 'コメントを登録する'
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test01@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        expect(page).not_to have_link 'コメント編集'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分以外が書いたコメントは削除リンクがない' do
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test02@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello2'
        click_button 'コメントを登録する'
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test01@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        expect(page).not_to have_link 'コメント削除'
      end
    end
  end

  describe '優待編集ページへアクセス' do
    context '優待編集ページへアクセスした場合' do
      it 'アクセスできずトップページへ戻される' do
        @special = FactoryBot.create(:special)
        visit edit_special_path(@special)
        expect(page).to have_content 'PER低い順でソート'
      end
    end
  end

end

#管理者ログインありの場合の確認

RSpec.describe '管理者がログインして閲覧', type: :system do
  before do
    FactoryBot.create(:special)
    FactoryBot.create(:second_special)
    FactoryBot.create(:category)
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
    visit new_user_session_path
    fill_in 'Eメール', with: 'suzuki_test51@example.com'
    fill_in 'パスワード', with:'suzuki'
    click_on 'ログインする'
  end

  describe 'トップページへアクセス' do
    context 'トップページへアクセスした場合' do
      it '一覧が表示される' do
        visit specials_path
        expect(page).to have_content '製品名１'
      end
    end
    context 'トップページへアクセスした場合' do
      it '詳細ページへが表示される' do
        visit specials_path
        expect(page).to have_content '詳細ページへ'
      end
    end
    context 'トップページへアクセスした場合' do
      it '新しく優待を投稿するのリンクが表示される' do
        visit specials_path
        expect(page).to have_content '新しく優待を投稿する'
      end
    end
    context 'トップページへアクセスした場合' do
      it 'カテゴリーへリンクがある' do
        visit specials_path
        expect(page).to have_link '金券'
      end
    end
    context 'トップページへアクセスした場合' do
      it '▼PER低い順でソートを押すと、PER低い順でソートされる' do
        visit specials_path
        click_link '▼PER低い順でソート'
        expect(Special.order("per ASC").map(&:product)).to eq ["製品名２", "製品名１"]
      end
    end
    context 'トップページへアクセスした場合' do
      it '▼取得価格順にソートを押すと、取得価格の低い順でソートされる' do
        visit specials_path
        click_link '▼取得価格順にソート'
        expect(Special.order("price ASC").map(&:product)).to eq ["製品名２", "製品名１"]
      end
    end
  end

  describe '優待投稿ページへアクセス' do
    context '優待投稿ページへアクセスした場合' do
      it '優待新規投稿ができる' do
        visit new_special_path
        fill_in 'special_product', with: '製品名１１'
        fill_in 'special_company', with: '会社名１１'
        fill_in 'special_detail', with: '製品名１１の解説文'
        fill_in 'special_per', with: '16.1'
        select '並', from: 'special_status'
        fill_in 'special_price', with: '220000'
        click_button '登録する'
        click_button '登録する'
        visit specials_path
        expect(page).to have_content '製品名１１'
      end
    end
  end


  describe '詳細ページへアクセス' do
    context '詳細ページへアクセスした場合' do
      it '詳細ページが表示される' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).to have_content '解説'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '優待編集のリンクが表示される' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).to have_content '編集する'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '優待削除のリンクが表示される' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        expect(page).to have_content '削除する'
      end
    end
    context '詳細ページへアクセスした場合' do
      it 'コメントが登録できる', js: true do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは編集リンクがある' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_link 'コメント編集'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは編集できる' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        click_link 'コメント編集'
        click_button '更新する'
        expect(page).to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは削除リンクがある' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        expect(page).to have_link 'コメント削除'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分が書いたコメントは削除できる' do
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello'
        click_button 'コメントを登録する'
        click_link 'コメント削除'
        expect(page.accept_confirm).to eq "本当に削除しますか?"
        expect(page).not_to have_content 'hello'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分以外が書いたコメントは編集リンクがない' do
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test02@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello2'
        click_button 'コメントを登録する'
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test51@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        expect(page).not_to have_link 'コメント編集'
      end
    end
    context '詳細ページへアクセスした場合' do
      it '自分以外が書いたコメントは削除リンクがない' do
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test02@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        visit special_path(@special)
        fill_in 'comment_content', with: 'hello2'
        click_button 'コメントを登録する'
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'Eメール', with: 'suzuki_test51@example.com'
        fill_in 'パスワード', with:'suzuki'
        click_on 'ログインする'
        @special = FactoryBot.create(:special)
        expect(page).not_to have_link 'コメント削除'
      end
    end
  end

  context '優待編集ページへアクセスした場合' do
    it '優待更新ができる' do
      @special = FactoryBot.create(:special)
      visit edit_special_path(@special)
      fill_in 'special_product', with: '製品名３１'
      fill_in 'special_company', with: '会社名３１'
      fill_in 'special_detail', with: '製品名３１の解説文'
      fill_in 'special_per', with: '13.2'
      select '割安', from: 'special_status'
      fill_in 'special_price', with: '220000'
      click_button '更新する'
      visit specials_path
      expect(page).to have_content '製品名３１'
    end
  end

  context '優待削除した場合' do
    it '優待削除ができる' do
      @special = FactoryBot.create(:second_special)
      visit special_path(@special)
      click_link '削除する'
      expect(page.accept_confirm).to eq "本当に削除していいですか？"
      expect(page).to have_content '製品名２'
    end
  end

end
