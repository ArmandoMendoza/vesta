require 'spec_helper'

describe Contractor do

  it { should have_many(:projects) }
  it { should have_many(:users) }

end
