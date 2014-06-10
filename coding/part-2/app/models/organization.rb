class Organization
  include Virtus.model(finalize: false)

  attribute :name, String
  attribute :user_roles, Array['UserRole']

  attribute :parent, Organization
  attribute :children, Array[Organization]

  def add_user(user, role)
    user_roles << UserRole.new(user: user, organization: self, role: role)
  end

  def parent=(p)
    p.children << self
    @parent = p
  end

  def users
    user_roles.map(&:user).uniq
  end
end
