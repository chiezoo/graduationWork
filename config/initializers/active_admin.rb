ActiveAdmin.setup do |config|
  # == Site Title
  config.site_title = "App"

  # タイトル（App）をクリックした時にアプリのトップページに戻る設定
  config.site_title_link = "/"

  # == User Authentication
  # 管理者専用の authenticate_admin_user! ではなく、通常の authenticate_user! を使用します
  config.authentication_method = :authenticate_admin_user!
  # config.authentication_method = :authenticate_user!

  # == Current User
  # 現在のユーザー取得も current_admin_user ではなく current_user を参照するようにします
  # config.current_user_method = :current_admin_user
  config.current_user_method = :current_user

  # == Logging Out
  # ログアウトパスも User モデル（Devise）のものに合わせます
  # config.logout_link_path = :destroy_admin_user_session_path
  config.logout_link_path = :destroy_user_session_path

  # == Batch Actions
  config.batch_actions = true

  # == Attribute Filters
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  # == Localize Date/Time Format
  config.localize_format = :long

  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      # 「events_path」または「root_path」へのリンクを追加
      # priority: 0 にすると一番左側に表示されます
      menu.add label: "カレンダーに戻る", url: "/", priority: 0
    end
  end

  # --- 以下、デフォルト設定 ---
  # config.localize_format = :long
end
