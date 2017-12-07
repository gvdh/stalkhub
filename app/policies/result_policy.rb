class ResultPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.joins(:provider).where(providers: { user: user })
    end
  end
end
