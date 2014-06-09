## User, Roles & Organizations Kata

Developed classes & tests to represent problem mentioned [here](http://www.adomokos.com/2012/10/the-organizations-users-roles-kata.html).

## Usage

You simply ask a user if he has access or is denied to an organization.  The logic for organization inheritenance and user permissions is abstracted away in services.

```ruby
current_user.admin_for?(organization)
current_user.has_access_to?(organization)
current_user.denied_access_to?(organization)
```

The `specs/features` directory has some example usages in detail.
