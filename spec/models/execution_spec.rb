require 'spec_helper'

describe Execution do
  it { should belong_to(:activity) }

  it { should validate_presence_of(:percent) }
  it { should validate_numericality_of(:percent) }

  it "should set date if date is no present" do
    execution = Execution.new(percent: 10)
    execution.save
    expect(execution.date).to eq(Date.today)
    expect(execution.percent).to eq(10)
  end

  describe "Callbacks" do
    describe "change_state_of_activity" do
      it "change state of activity to finished if percent is 100" do
        activity = Activity.make!
        execution = Execution.new(percent: 100, activity_id: activity.id)
        execution.save
        activity.reload
        expect(activity.state).to eq(Activity::STATE[:finished])
      end
    end
  end
end
