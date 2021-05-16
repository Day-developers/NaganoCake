class ApplicationController < ActionController::Base
  # ログイン後及びログアウト後の遷移先(顧客側は保留)
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

end
