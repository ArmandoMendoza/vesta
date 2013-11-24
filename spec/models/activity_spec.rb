require 'spec_helper'

describe Activity do
  it { should belong_to(:project) }
  it { should have_many(:executions) }

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
