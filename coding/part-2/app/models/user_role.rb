class UserRole
  include Virtus.model(finalize: false)

  ROLES = %i(admin user denied)

  attribute :user, 'User'
  attribute :organization, 'Organization'
  attribute :role, Symbol, default: :user

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end
end
