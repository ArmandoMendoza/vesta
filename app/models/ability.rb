class Ability
  include CanCan::Ability

  def initialize(user, project)
    if user.admin?
      admin_user_permitions
    elsif (user.owner? && user.belongs_to_contractor?)
      owner_contractor_abilities(user)
    elsif (user.owner? && user.belongs_to_sub_contractor?)
      owner_sub_contractor_abilities(user)
    elsif (user.regular? && user.belongs_to_contractor?)
      regular_contractor_abilities(user)
    elsif (user.regular? && user.belongs_to_sub_contractor?)
      regular_sub_contractor_abilities(user)
      if project.present? && project.role_of(user) == "Residente"
        resident_abilities(user, project)
      end
    end
  end

  private
    def admin_user_permitions
      can :manage, :all
    end

    def owner_sub_contractor_abilities(user)
      can [:read, :update], SubContractor, id: user.company.id
      can [:read, :create, :update], Project, sub_contractor_id: user.company.id

      #Usuarios
      can :read, User
      can [:create, :update], User do |company_user|
        company_user.company == user.company
      end

      #Colaboradores
      can :read, Collaborator
      can :create, Collaborator do |collaborator|
        collaborator.project.sub_contractor == user.company
      end
      can :update, Collaborator do |collaborator|
        collaborator.project.sub_contractor == user.company &&
        collaborator.user.company == user.company
      end

      #Actividades
      can :index, Activity
      can [:show, :create, :update], Activity do |activity|
        activity.project.sub_contractor == user.company
      end

      #Imagenes
      can :manage, Image
    end

    def owner_contractor_abilities(user)
      can :read, [SubContractor, Contractor, User, Project, Collaborator, Activity]
      can :create, Execution
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

    def regular_contractor_abilities(user)
      can :manage, User, id: user.id
      can :read, Contractor, id: user.company.id
      can :read, Project, contractor_id: user.company.id
    end

    def regular_sub_contractor_abilities(user)
      can :manage, User, id: user.id
      can :read, SubContractor, id: user.company.id
      can :read, Project, sub_contractor_id: user.company.id
    end

    def resident_abilities(user, project)
      #Actividades
      can :index, Activity
      can :show, Activity do |activity|
        activity.follower?(user)
      end

      #Imagenes
      can :manage, Image
    end
end
