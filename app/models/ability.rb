class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :details, :show,  :to => :read
    if user && user.role == :admin
      can :manage, :all
    elsif user && user.role == :manager  
      can :manage, Case, id: user.cases.pluck(:id)
      can :manage, Disbursment, :case => {:id => user.cases.pluck(:id)}
      can :manage, Request, :case => {:id => user.cases.pluck(:id)}
    elsif user && user.role == :doctor
      can :read, Case, id: user.cases.pluck(:id)
      can :manage, Comment, :user_id => user.id  
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
