require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    #be_validとはバリデーション実行時の値がtrueであることを確かめるマッチャ
    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nameが空では登録できないこと' do
      @user.name = ''
      @user.valid?
      #@user.errors.full_messagesでエラー文を特定させる
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
      #includeとはexpectの引き数にincludeの引数が含まれていることを確認するマッチャ。
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")

    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '000000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailが存在する場合登録できないこと' do
      #生成した@userをテーブルへ保存後、
      @user.save
      #別のユーザーanother_userを生成する。
      #FactoryBotを用いて、user情報(email)だけを選択してインスタンスを生成
      #生成したインスタンスをanother_userへ代入します。
      another_user = FactoryBot.build(:user,email: @user.email)
      #another_user.email へ すでに保存済みの@userのemail情報を上書きする。
      another_user.email = @user.email
      #.valid?でanother_userがDBへ保存できるか判別
      another_user.valid?
      #faluseとなるため。
      #another_user.errorsでエラーを出して、another_user.errors.full_mseeagesでエラー全文を表示。
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end