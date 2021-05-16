class ApplicationController < ActionController::Base
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    end
  end

end
