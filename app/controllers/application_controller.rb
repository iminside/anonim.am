class ApplicationController
  
  protected

  def check_auth
    stop unless @user = client[ :user ]
  end

end
