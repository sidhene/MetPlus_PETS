require 'rails_helper'

RSpec.describe AgencyRelation, type: :model do
  describe 'Fixtures' do
    it 'should have a valid factory' do
      expect(FactoryGirl.create(:agency_relation)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to :agency_person }
    it { is_expected.to belong_to :job_seeker }
    it { is_expected.to belong_to :agency_role }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :agency_person_id }
    it { is_expected.to have_db_column :job_seeker_id }
    it { is_expected.to have_db_column :agency_role_id }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :agency_person }
    it { is_expected.to validate_presence_of :job_seeker }
    it { is_expected.to validate_presence_of :agency_role }
  end

  describe 'AgencyPerson <> JobSeeker relation' do
    let(:person)     { FactoryGirl.create(:agency_person) }
    let(:job_seeker) { FactoryGirl.create(:job_seeker) }
    let(:role)       { FactoryGirl.create(:agency_role) }

    it 'is valid with all required fields' do
      expect(AgencyRelation.new(agency_person: person,
                agency_role: role,
                job_seeker: job_seeker)).to be_valid
    end
    it 'is invalid without an agency_person, role or job_seeker' do
      relation = AgencyRelation.new()
      relation.valid?
      expect(relation.errors[:agency_person]).to include("can't be blank")
      expect(relation.errors[:agency_role]).to include("can't be blank")
      expect(relation.errors[:job_seeker]).to include("can't be blank")
    end

    context 'Job Developer and Case Manager Relationships' do
      let(:cm_person)   do
        $person = FactoryGirl.build(:agency_person, agency: agency)
        $person.agency_roles << FactoryGirl.create(:agency_role,
                                        role: AgencyRole::ROLE[:CM])
        $person.save
        $person
      end
      let(:jd_person)   do
        $person = FactoryGirl.build(:agency_person, agency: agency)
        $person.agency_roles << FactoryGirl.create(:agency_role,
                                        role: AgencyRole::ROLE[:JD])
        $person.save
        $person
      end

      it 'sets the Job Developer for a Job Seeker' do
      end

      it 'sets the Case Manager for a Job Seeker' do
      end

      it 'finds the Job Developer for a Job Seeker' do
      end

      it 'finds the Case Manager for a Job Seeker' do
      end

      it 'finds the Job Seeker relationship for a given ' do
      end
    end
  end
end
