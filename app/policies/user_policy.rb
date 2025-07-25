class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.user?
        scope.where.not(role: 'admin')
      else
        scope.where(id: user.id)
      end
    end
  end

  def index?
    user.admin? || user.user? || user.id == record.id
  end

  def search?
    user.admin? || user.user? || user.id == record.id
  end

  def destroy?
    user.admin? && user.id != record.id
  end

  def inactivate?
    user.admin? && user.id != record.id
  end
end
