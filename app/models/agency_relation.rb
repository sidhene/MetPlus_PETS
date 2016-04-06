class AgencyRelation < ActiveRecord::Base
  belongs_to :agency_person
  belongs_to :job_seeker
  belongs_to :agency_role

  validates_presence_of :agency_person, :job_seeker, :agency_role

  def self.in_role_of role_key
    where(agency_role_id: AgencyRole.find_by_role(AgencyRole::ROLE[role_key]).id)
  end

  def self.in_role role_key
    AgencyRelation.where(agency_role_id: AgencyRole.find_by_role(AgencyRole::ROLE[role_key]).id).collect(&:job_seeker)
  end

  # create scopes to allow pagination of results
  scope :job_developer, -> {where(agency_role_id: AgencyRole.find_by_role(AgencyRole::ROLE[:JD]).id)}

  def self.js_without_jd
    js_ids_with_a_jd = AgencyRelation.in_role_of(:JD).pluck(:job_seeker_id)
    JobSeeker.where.not(js_ids_with_a_jd)
  end


  # Helper methods for associating job seekers with agency people
  # These business rules are enforced:
  # 1) A job developer can have only one case manager
  # 2) A job developer can have only one job developer ('primary' JD)

end
