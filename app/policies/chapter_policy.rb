class ChapterPolicy < ApplicationPolicy

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
        scope.all
      end
    end
  end


  attr_reader :user, :chapter

  def initialize(user, chapter)
    @user = user
    @chapter = chapter
  end

  def update?
    admin_or_owner
  end
  
  def edit?
    admin_or_owner
  end

  def update?
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
    user.admin? or chapter.book.users.include?(user)
  end
end
