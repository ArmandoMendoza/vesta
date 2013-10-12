require 'spec_helper'

describe Project do

  it { should belong_to(:contractor) }
  it { should belong_to(:sub_contractor) }
  it { should have_many(:collaborators) }
  it { should have_many(:users).through(:collaborators) }

end
