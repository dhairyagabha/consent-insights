class PropertyPolicy < ApplicationPolicy
  attr_reader :user, :property

  def initialize(user, property)
    @user     = user
    @property = property
  end

  def update?
    @property.admins.include? @user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
      #   scope.all
      # else
        scope.joins(:teams).where("team_id IN (?)", @user.teams.map{|t| t.id})
      end
    end

    private

    attr_reader :user, :scope
  end
end
