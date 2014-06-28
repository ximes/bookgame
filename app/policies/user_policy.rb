class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    admin_or_owner
  end
  
  def show?
    admin_or_owner
  end

  def update?
    admin_or_owner
  end

  def edit?
    admin_or_owner
  end

  def destroy?
    return false if @current_user == @user
    admin_or_owner
  end
  
  def admin_or_owner
    @current_user.admin? or @current_user == @user
  end
end