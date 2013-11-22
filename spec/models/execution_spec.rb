require 'spec_helper'

describe Execution do
  it { should belong_to(:activity) }

  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:percent) }
  it { should validate_numericality_of(:percent) }
end
