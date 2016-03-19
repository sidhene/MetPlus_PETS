class JobSeeker < ActiveRecord::Base
  acts_as :user
  belongs_to :job_seeker_status
  #has_one    :resume

  has_one	   :address, as: :location
  has_many   :agency_relations
  has_many   :agency_people, through: :agency_relations

  validates_presence_of :year_of_birth, :job_seeker_status_id #,:resume
  validates  :year_of_birth, :year_of_birth => true

    def case_manager=(cm_person)
      AgencyRelation.assign_case_manager_to_job_seeker(self, cm_person)
    end

    def case_manager
      AgencyRelation.case_manager_for_job_seeker(self)
    end

    def job_developer
      AgencyRelation.job_developer_for_job_seeker(self)
    end

end
