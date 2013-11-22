class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      admin_user_permitions
    elsif (user.owner? && user.company_type == "Contractor")
      owner_contractor_abilities(user)
    elsif (user.owner? && user.company_type == "SubContractor")
      owner_sub_contractor_abilities(user)
    end
  end

  private
    def admin_user_permitions
      can :manage, :all
    end

    def owner_sub_contractor_abilities(user)
      can :read, [SubContractor, Contractor, User, Project, Collaborator, Activity]
      can :update, SubContractor, id: user.company.id
      can [:create, :update], User do |company_user|
        company_user.company == user.company
      end
      can [:create, :update], Project, sub_contractor_id: user.company.id
      can :create, Collaborator do |collaborator|
        collaborator.project.sub_contractor == user.company
      end
      can :update, Collaborator do |collaborator|
        collaborator.project.sub_contractor == user.company &&
        collaborator.user.company == user.company
      end
      can [:create, :update], Activity do |activity|
        activity.project.sub_contractor == user.company
      end
    end

    def owner_contractor_abilities(user)
      can :read, [SubContractor, Contractor, User, Project, Collaborator, Activity]
      can :update, Contractor, id: user.company.id
      can [:create, :update], User do |company_user|
        company_user.company == user.company
      end
      can :create, Collaborator do |collaborator|
        collaborator.project.contractor == user.company
      end
      can :update, Collaborator do |collaborator|
        collaborator.project.contractor == user.company &&
        collaborator.user.company == user.company
      end
      can [:create, :update], Activity do |activity|
        activity.project.contractor == user.company
      end
    end

    def regular_user
      can :manage, User, id: user.id
    end
end
