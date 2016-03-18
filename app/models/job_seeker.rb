class JobSeeker < ActiveRecord::Base
  acts_as :user
  belongs_to :job_seeker_status
  #has_one    :resume

  has_one	   :address, as: :location
  has_many   :agency_relations
  has_many   :agency_people, through: :agency_relations

  validates_presence_of :year_of_birth, :job_seeker_status_id #,:resume
  validates  :year_of_birth, :year_of_birth => true

    def case_manager=(case_manager)
      debugger
        self.agency_relations <<
            AgencyRelation.create(
               agency_role_id: AgencyRole.find_by_role(AgencyRole::ROLE[:CM]),
                               agency_person_id: case_manager.id)
        self.save
        self
    end
    def case_manager
      find_agency_person_with_role(AgencyRole::ROLE[:CM])
    end

    def job_developer
      find_agency_person_with_role(AgencyRole::ROLE[:JD])
    end

    private

    def find_agency_person_with_role(role_id)
      if not agency_relations.empty?
        ap_relation = agency_relations.where(agency_role: AgencyRole.
                  find_by_role(role_id))[0] # get first if multiple
        return ap_relation.agency_person if ap_relation
      end
      nil # return nil if agency person with role is not found
    end
end
