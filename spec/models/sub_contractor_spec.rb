require 'spec_helper'

describe SubContractor do

  it { should have_many(:projects) }
  it { should have_many(:users) }

  it { should allow_value("J-31446097-8").for(:rif) }
  it { should allow_value("276-3535240").for(:phone) }
  it { should_not allow_value("J322323-23").for(:rif) }
  it { should_not allow_value("aasdad").for(:phone) }
end
