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

    def owner_contractor_abilities(user)
      can :read, [Contractor, SubContractor, Project]
      can :manage, User, company_id: user.company.id
      can :update, Contractor, id: user.company.id
      can :manage, Collaborator, project: { contractor_id: user.company.id },
        user: { company_id: user.company.id }
      can :create, Collaborator
    end

    def owner_sub_contractor_abilities(user)
      can :read, [Contractor, SubContractor]
      can :manage, Project, company_id: user.company.id
      can :manage, User, company_id: user.company.id
      can :update, Contractor, id: user.company.id
      can :manage, Collaborator, project: { company_id: user.company.id },
        user: { company_id: user.company.id }
      can :create, Collaborator
    end

    def regular_user
      can :manage, User, id: user.id
    end
end
