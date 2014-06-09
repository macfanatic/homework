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

    if user.organization == organization
      user_role.role
    else
      :denied
    end
  end

  private

  def ensure_user_and_organization_provided
    raise ArgumentError, 'user & organization required' if user.nil? || organization.nil?
  end

  def user_role
    @user_role ||= organization.user_roles.find { |r| r.user == user }
  end

end
