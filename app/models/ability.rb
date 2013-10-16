class Ability
  include CanCan::Ability

  def initialize(user)
    admin_permitions if user.admin?
    admin_permitions if user.owner?
    admin_permitions if user.regular?
  end

  private
    def admin_permitions
      can :manage, :all
    end
end
