require 'rails_helper'

describe JobSeeker, type: :model do
  describe 'Fixtures' do
    it 'should have a valid factory' do
      expect(FactoryGirl.create(:job_seeker)).to be_valid
    end
  end

  	it {is_expected.to have_db_column :year_of_birth}
  	it {is_expected.to have_db_column :job_seeker_status_id }
  	it {is_expected.to have_db_column :resume }

  	it {is_expected.to validate_presence_of(:year_of_birth)}
  	xit {is_expected.to validate_presence_of(:resume)}
    it {is_expected.to validate_presence_of(:job_seeker_status_id)}
  	it {is_expected.to have_many(:agency_people).through(:agency_relations)}

<<<<<<< HEAD
=======

>>>>>>> fc3473be4a4ec96e5593b902a227777d9d5e6fe3
  	it{should allow_value('1987', '1916', '2000', '2014').for(:year_of_birth)}
  	it{should_not allow_value('1911', '899', '1890', 'salem').for(:year_of_birth)}

  	context "#acting_as?" do
    	it "returns true for supermodel class and name" do
    		expect(JobSeeker.acting_as? :user).to be true
    		expect(JobSeeker.acting_as? User).to  be true
    	end

    	it "returns false for anything other than supermodel" do
    		expect(JobSeeker.acting_as? :model).to be false
    		expect(JobSeeker.acting_as? String).to be false
    	end
  	end
    #
    # describe "Relationships" do
    #   let(:agency) { FactoryGirl.create(:agency) }
    #   let(:cm_person)   do
    #     $person = FactoryGirl.build(:agency_person, agency: agency)
    #     $person.agency_roles << FactoryGirl.create(:agency_role,
    #                                     role: AgencyRole::ROLE[:CM])
    #     $person.save
    #     $person
    #   end
    #   let(:jd_person)   do
    #     $person = FactoryGirl.build(:agency_person, agency: agency)
    #     $person.agency_roles << FactoryGirl.create(:agency_role,
    #                                     role: AgencyRole::ROLE[:JD])
    #     $person.save
    #     $person
    #   end
    #   let(:job_seeker) do
    #     $person = FactoryGirl.build(:job_seeker)
    #     @user = FactoryGirl.create(:user)
    #     @jobseekerstatus = FactoryGirl.create(:job_seeker_status)
    #     jobseeker_hash = FactoryGirl.attributes_for(:job_seeker).merge(FactoryGirl.attributes_for(:user)).merge(FactoryGirl.attributes_for(:job_seeker_status))
    #     $person.agency_people << :cm_person, :jd_person
    #   end
    # end

end
