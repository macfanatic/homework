## Controller Refactoring
First off, I've never seen a controller this bad in my life and hope to never run across one either.  However, there is obviously a lot of room for improvement and my suggestions are below.

* Rename controller class for clarity, ie `CandidatesController`
* Rename `#show_candidates` action to `#show` or `#index`
* Render a view instead of a partial, I would use implicit rendering
* Create a presenter, or a private method, that examines the `params` hash and returns a Symbol for an ActiveRecord relation to be used for sorting the records
* Get rid of the `sort_by` and `sort!` in-memory calls and write out ActiveRecord scopes for each scenario
* Write a private method that determines what scope and applies it to the relation to order the results
* Checks on line 35 should be in an ActiveRecord scope instead of checking every db record
* Ditch all the `if found == true` code that is ensuring uniqueness and use a call to `uniq` in ActiveRecord
* No reason to expose locals with of `:@candidates` to template, just use the instance variables in the template

What might all that actually look like, in brevity?


```ruby

class CandidatesController < ApplicationController

  def index
    if can_view_candidates?
      @candidates = apply_scope current_user.organization.candidates
    else

      # Still not ideal - would spend more time to make this 1 query instead of n+1
      # but it is better than what was here before :)
      @candidates = current_user.jobs.map do |job|
        apply_scope job.candidates
      end.flatten.uniq
    end
  end

  private

  def apply_scope(relation)
    relation.public_send sort_scope
  end

  def can_view_candidates?
    current_user.has_permission? :view_candidates
  end

  def sort_scope
    params[:sort] ||= "All Candidates"

    case params[:sort]
    when "All Candidates"
      :all
    when "Candidates Newest -> Oldest"
      :recent
    # continue on...
    end
  end
end
```

```ruby

class Job < ActiveRecord::Model
  default_scope ->{ where is_deleted: false }

  has_many :job_candidates, class_name: "CandidateJob"
  has_many :candidates, through: :job_candidates
end
```

```ruby

class User < ActiveRecord::Model
  has_many :job_contacts
  has_many :jobs, through: :job_contacts
end
```

```ruby

class Candidate < ActiveRecord::Model

  default_scope -> { where is_deleted: false, completed: true }
  scope :recent, ->{ order :created_at.desc }
  scope :alphabetical, ->{ recent.order arel_table[:last_name].lower.asc }
  scope :alpha_reversed, ->{ recent.order arel_table[:last_name].lower.desc }
end
```
