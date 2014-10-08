require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "WILL NOT create an empty project" do
	  p = Project.new
    assert !p.save
  end

  test "WILL Create Project with valid client and project names" do
  	p = Project.new
	  p.client_name = "fred"
	  p.project_name = "freds project"
	  assert p.save
  end

  test "WILL NOT Create Project with empty project name" do
  	p = Project.new
	  p.client_name = "fred"
	  assert !p.save
  end

  test "WILL NOT Create Project with empty client name" do
  	p = Project.new
	  p.project_name = "fred's project"
	  assert !p.save
  end

end
