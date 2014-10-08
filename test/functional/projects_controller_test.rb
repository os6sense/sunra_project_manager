require 'test_helper'
require 'warden_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    admin = Admin.find(1)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admin

    @project = projects(:one)
  end

  # ========================================================
  # INDEX 
  # ========================================================
  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  # ========================================================
  # NEW
  # ========================================================
  test "should get new" do
    get :new
    assert_response :success
  end

  # ========================================================
  # CREATE
  # ========================================================
  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { client_name: "fred", project_name: "bob" }
    end
    assert_redirected_to project_path(assigns(:project))

    assert_not_nil Project.find_by_client_name("fred"), "should find client by name"
  end

  # ========================================================
  # SHOW
  # ========================================================
  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  # ========================================================
  # EDIT
  # ========================================================
  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  # ========================================================
  # UPDATE
  # ========================================================
  test "should update project" do
    updated_name = "#{@project.client_name}UPDATED" 
    put :update, id: @project, project: { client_name: updated_name,
      project_name: @project.project_name }
    assert_redirected_to project_path(assigns(:project))

    assert_not_nil Project.find_by_client_name(updated_name),
      "should find updated client by name"
  end

  # ========================================================
  # DESTROY
  # ========================================================
  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end
    assert_nil Project.find_by_uuid @project.uuid, 
      "No Project should be found since it was deleted"
    assert_redirected_to projects_path
  end
end
