class Ability
  include CanCan::Ability

  def initialize(user)
    admin_permitions if user.admin?
  end

  private
    def admin_permitions
      can :manage, :all
    end
end
