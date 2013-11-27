require 'spec_helper'

describe Follower do
  it { should belong_to(:user) }
  it { should belong_to(:activity) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:activity_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:activity_id) }
end
