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
      can :read, [SubContractor, Contractor, User]
      can :update, SubContractor, id: user.company.id
      can [:create, :update], User do |company_user|
        company_user.company == user.company
      end

      can :manage, Project, sub_contractor_id: user.company.id
      can [:read, :create], Collaborator
      can :update, Collaborator, project: { sub_contractor_id: user.company.id },
        user: { company_id: user.company.id }
      can :create, Collaborator
    end

    def owner_contractor_abilities(user)
      can :read, [SubContractor, Contractor, User]
      can :update, Contractor, id: user.company.id
      can [:create, :update], User do |company_user|
        company_user.company == user.company
      end

      can :read, Project, contractor_id: user.company.id
      can [:read, :create], Collaborator
      can :update, Collaborator, project: { contractor_id: user.company.id },
        user: { company_id: user.company.id }
    end

    def regular_user
      can :manage, User, id: user.id
    end
end
