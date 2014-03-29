require 'spec_helper'

describe Task do
  it { should belong_to(:activity) }
  it { should validate_presence_of(:description) }
  it { should have_and_belong_to_many(:users) }
end
