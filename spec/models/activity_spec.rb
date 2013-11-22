require 'spec_helper'

describe Activity do
  it { should belong_to(:project) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:init_date) }
  it { should validate_presence_of(:execution_time) }
  it { should validate_presence_of(:unit_execution_time) }
  it { should validate_numericality_of(:execution_time) }


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
  end
end
