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

  [:update?,:create?,:new?,:edit?,:show?,:index?,:destroy?].each do |action|
    define_method "#{action}" do
      admin_or_owner
    end  
  end

  def admin_or_owner
    user.admin? or chapter.book.users.include?(user)
  end
end
