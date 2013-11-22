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
end
