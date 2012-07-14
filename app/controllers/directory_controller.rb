class DirectoryController < ApplicationController
  include Hydra::Controller::ControllerBehavior

  # returns true if the user exists and false otherwise
  def user
    render :json => ScholarSphere::LDAP.get_user(params[:uid]) 
  end

  def user_attribute
    if params[:attribute] == "groups"
      res = ScholarSphere::LDAP.groups_for_user(params[:uid])
    else
      res = ScholarSphere::LDAP.get_user(params[:uid], [params[:attribute]])
    end
    render :json => res
  end

  def user_groups
    render :json => ScholarSphere::LDAP.groups_for_user(params[:uid]) 
  end

  def group
    puts params[:cn]
    render :json => ScholarSphere::LDAP.does_group_exist?(params[:cn])
  end
end
