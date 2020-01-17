# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
     
    if user.roll == 2    #管理者
      can :manage, :all
    elsif user.roll == 1 #一般ユーザー
      #can :read, :hello
    end
  end
end
