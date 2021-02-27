require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    # new_user_session（サインインページ）
    expect(current_path).to eq(new_user_session_path)
  end

    # build
    # メモリ上にインスタンスを確保する。
    # DB上にはデータがないので、DBにアクセスする必要があるテストのときは使えない。
    # DBにアクセスする必要がないテストの時には、インスタンスを確保する時にDBにアクセスする必要がないので処理が比較的軽くなる。

    # create
    # DB上にインスタンスを永続化する。
    # DB上にデータを作成する。
    # DBにアクセスする処理のときは必須。（何かの処理の後、DBの値が変更されたのを確認する際は必要）

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    @user.save

    # サインインページへ移動する
    visit new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in "Email",with:@user.email
    fill_in "Password",with:@user.password

    # ログインボタンをクリックする
    click_on('Log in')

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
    
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    #DBに保存する場合はcreate
    @user = FactoryBot.create(:user)
    @user.save

    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)

    # 誤ったユーザー情報を入力する
    fill_in "Email",with:'test'
    fill_in "Password",with:'test'

    # ログインボタンをクリックする
    click_on('Log in')

    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)

  end
end