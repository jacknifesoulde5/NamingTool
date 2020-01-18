class ApplicationController < ActionController::Base
  # 各アクションで権限をチェック。オプションでモデル依存をfalseに。
  authorize_resource :class => false

  # 権限が無いページへアクセス時の例外処理
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to tool_index_path
  end

  # ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
    tool_index_path
  end

  # ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(resource)
    tool_index_path
  end
end
