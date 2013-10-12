require 'spec_helper'

describe SubContractor do

  it { should have_many(:projects) }
  it { should have_many(:users) }

end
