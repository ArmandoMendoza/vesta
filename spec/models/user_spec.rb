require 'spec_helper'

describe User do

  it { should belong_to(:company) }
  it { should have_many(:collaborators) }
  it { should have_many(:projects).through(:collaborators) }

end
