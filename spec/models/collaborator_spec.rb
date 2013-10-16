require 'spec_helper'

describe Collaborator do

  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:project_id) }
  it { should validate_presence_of(:collaborator_type) }
  it { should validate_uniqueness_of(:collaborator_type).scoped_to(:project_id) }

end
