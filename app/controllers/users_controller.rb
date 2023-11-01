class UsersController < ApplicationController
  def edit
    # binding.pry
  end
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def user_params
    # paramsハッシュは色んな情報が入っているため、取得する情報を限定するために、requireでフォーム記入欄の指定カラムと紐づけたモデル名を、permitではフォームの中の情報から更に必要な入力欄を絞るために、フォームで紐づけたカラム名を記載する
    # mergeで他データベースの値をテーブルへ追加するデータに含めることができる
    # current_userでログイン中のレコードを抽出
    params.require(:user).permit(:name,:email)
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
