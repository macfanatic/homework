class DetermineUserAccessForOrganization
  include Virtus.model

  attribute :user, User
  attribute :organization, Organization

  UserRole::ROLES.each do |role|
    define_method "#{role}?" do
      access_symbol == role
    end
  end

  def access_symbol
    ensure_user_and_organization_provided

    if nearest_organization.nil?
      :denied
    else
      user_role.role
    end
  end

  private

  def nearest_organization
    @nearest_organization ||= find_nearest_organization_from_tree(organization)
  end

  def find_nearest_organization_from_tree(organization)
    if organization.users.include? user
      organization
    else
      if organization.parent.nil?
        nil
      else
        find_nearest_organization_from_tree(organization.parent)
      end
    end
  end

  def ensure_user_and_organization_provided
    raise ArgumentError, 'user & organization required' if user.nil? || organization.nil?
  end

  def user_role
    @user_role ||= nearest_organization.user_roles.find { |r| r.user == user }
  end

end
