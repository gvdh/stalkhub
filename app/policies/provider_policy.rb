class ProviderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def create?
    !user.nil?
  end

  def update?
    record.user == user
  end
end
