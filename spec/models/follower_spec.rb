require 'spec_helper'

describe Follower do
  it { should belong_to(:user) }
  it { should belong_to(:activity) }
end
