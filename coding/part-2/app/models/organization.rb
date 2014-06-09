class Organization
  include Virtus.model(finalize: false)

  attribute :name, String
  attribute :user_roles, Array['UserRole']

  def add_user(user, role)
    user.organization = self
    user_roles << UserRole.new(user: user, organization: self, role: role)
  end

  def users
    user_roles.map(&:user).uniq
  end
end
