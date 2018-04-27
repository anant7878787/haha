class TeamPolicy < ApplicationPolicy

  def update?
    # user.admin? or not post.published?
  end


  def show?
   return true if record.find_teamusers_to_show.include? @current_user
  end
end