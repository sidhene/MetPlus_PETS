class AgencyRelation < ActiveRecord::Base
  belongs_to :agency_person
  belongs_to :job_seeker
  belongs_to :agency_role

  validates_presence_of :agency_person, :job_seeker, :agency_role

  def self.in_role_of role_key
    where(agency_role_id: AgencyRole.find_by_role(AgencyRole::ROLE[role_key]).id)
  end

  # Helper methods for associating job seekers with agency people
  # These business rules are enforced:
  # 1) A job developer can have only one case manager
  # 2) A job developer can have only one job developer ('primary' JD)

  def self.case_manager_for_job_seeker(job_seeker)
    find_agency_person_for_job_seeker(job_seeker, :CM)
  end

  def self.job_developer_for_job_seeker(job_seeker)
    find_agency_person_for_job_seeker(job_seeker, :JD)
  end

  def self.assign_case_manager_to_job_seeker(job_seeker, case_manager)
    assign_agency_person_to_job_seeker(job_seeker, case_manager, :CM)
  end

  def self.assign_job_developer_to_job_seeker(job_seeker, job_developer)
    assign_agency_person_to_job_seeker(job_seeker, job_developer, :JD)
  end

  def self.assign_agency_person_to_job_seeker(job_seeker, agency_person, role_key)
    raise 'Not a job seeker'   if not job_seeker.is_a? JobSeeker
    raise 'Not an agency person' if not agency_person.is_a? AgencyPerson
    raise 'AgencyPerson does not have appropriate role' if
            agency_person.agency_roles.empty? ||
            !agency_person.agency_roles.
                  include?(AgencyRole.find_by_role(AgencyRole::ROLE[role_key]))

    if (ap_relation = job_seeker.agency_relations.in_role_of(role_key)[0])
      # Is this role assigned already to an agency person?

      # If so, is this the same agency person? - then we're done
      return if ap_relation.agency_person == agency_person

      # Otherwise, reassign case manager role for this job seeker
      ap_relation.agency_person = agency_person
      ap_relation.save
    else
      # Otherwise, assign this agency person, in this role, to job seeker
      AgencyRelation.create(agency_person: agency_person,
              job_seeker: job_seeker,
              agency_role: AgencyRole.find_by_role(AgencyRole::ROLE[role_key]))
    end
  end

  def self.find_agency_person_for_job_seeker(job_seeker, role_key)
    raise 'Not a job seeker' if not job_seeker.is_a? JobSeeker
    if not job_seeker.agency_relations.empty?
      ap_relation = job_seeker.agency_relations.in_role_of(role_key)[0]
      return ap_relation.agency_person if ap_relation
    end
    nil # return nil if no agency person found for that role
  end

end
