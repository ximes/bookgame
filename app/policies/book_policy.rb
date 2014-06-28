class BookPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:active => true).owned_by(user)
      end
    end
  end

  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def update?
    admin_or_owner
  end

  def edit?
    admin_or_owner
  end

  def show?
    admin_or_owner
  end

  def index?
    admin_or_owner
  end

  def destroy?
    admin_or_owner
  end

  def admin_or_owner
    user.admin? or book.users.include?(user)
  end
end