class User
  include Virtus.model

  attribute :name, String

  def admin_for?(organization)
    service_for(organization).admin?
  end

  def has_access_to?(organization)
    service_for(organization).user?
  end

  def denied_access_to?(organization)
    service_for(organization).denied?
  end

  private

  def service_for(organization)
    DetermineUserAccessForOrganization.new(user: self, organization: organization)
  end
end
