require 'spec_helper'

describe Activity do
  it { should belong_to(:project) }
  it { should have_many(:executions) }
  it { should have_many(:followers) }
  it { should have_many(:images) }
  it { should have_many(:users).through(:followers) }



  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:init_date) }
  it { should validate_presence_of(:execution_time) }
  it { should validate_presence_of(:unit_execution_time) }
  it { should validate_numericality_of(:execution_time) }

  describe "Instance methods" do
    describe "current_execution" do
      it "return the last execution of activity" do
        activity = Activity.make!
        execution_one = Execution.make!(activity: activity, percent: 10, date: Date.today - 2)
        execution_two = Execution.make!(activity: activity, percent: 30, date: Date.today - 1)
        execution_last = Execution.make!(activity: activity, percent: 70)
        expect(activity.current_execution).to eq(execution_last)
      end
    end

    describe "#role_of" do
      it "should return role of given user in the activity" do
        no_follower = User.make!(:sub_contractor_regular)
        user = User.make!(:sub_contractor_regular)
        project = Project.make!(sub_contractor: user.company)
        activity = Activity.make!(project: project)
        Follower.make!(:sub_contractor_regular, user: user, activity: activity)
        expect(activity.role_of(user)).to eq("Seguidor")
        expect(activity.role_of(no_follower)).to be_nil
      end
    end
  end

  describe "Callbacks" do
    describe "set_finish_date" do
      it "should set finish date with execution_time and unit_execution_time" do
        activity = Activity.new(name: "Activity 1", init_date: Date.today, execution_time: 20,
          unit_execution_time: Activity::UNIT[:days])
        activity.save
        expect(activity.finish_date).to eq(activity.init_date + 20.days)
      end
    end
    describe "set_defaults" do
      it "should set state to executing and percent_of_the_project to 0" do
        activity = Activity.new(name: "Activity 1", init_date: Date.today, execution_time: 20,
          unit_execution_time: Activity::UNIT[:days])
        activity.save
        expect(activity.state).to eq(Activity::STATE[:executing])
        expect(activity.percent_of_the_project).to eq(0)
      end
    end

    describe "create_first_execution" do
      it "should create an execution with percent 0 when a activity is created" do
        activity = Activity.new(name: "Activity 1", init_date: Date.today, execution_time: 20,
          unit_execution_time: Activity::UNIT[:days])
        activity.save
        execution = activity.executions.last
        expect(execution.date).to eq(Date.today)
        expect(execution.percent).to eq(0)
      end
    end
  end
end
