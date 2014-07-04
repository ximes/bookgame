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
        scope.owned_by(user)
      end
    end
  end

  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  [:update?,:create?,:new?,:edit?,:show?,:index?,:destroy?].each do |action|
    define_method "#{action}" do
      admin_or_owner
    end  
  end

  def admin_or_owner
    user.admin? or book.users.include?(user)
  end
end