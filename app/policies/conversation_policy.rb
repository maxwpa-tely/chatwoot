#class ConversationPolicy < ApplicationPolicy
#  def index?
#    true
#  end

#  def destroy?
#    @account_user&.administrator?
#  end
#end

class ConversationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if @account_user&.administrator?

    inbox_access = Current.user.assigned_inboxes.include?(record.inbox)
    return inbox_access if record.team_id.blank?

    inbox_access && Current.user.teams.exists?(id: record.team_id)
  end

  def destroy?
    @account_user&.administrator?
  end
end
