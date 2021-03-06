require 'test_helper'

class CollegesControllerTest < ActionController::TestCase
  setup do
    @college = colleges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colleges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create college" do
    assert_difference('College.count') do
      post :create, college: { id: @college.id, israelStudyAbroad: @college.israelStudyAbroad, jewishCourses: @college.jewishCourses, jewishMajor: @college.jewishMajor, jewishMinor: @college.jewishMinor, jewishPopGrad: @college.jewishPopGrad, jewishPopUndergrad: @college.jewishPopUndergrad, name: @college.name, popGrad: @college.popGrad, popUndergrad: @college.popUndergrad, programsOfStudy: @college.programsOfStudy, studyAbroad: @college.studyAbroad, uniqueCourses: @college.uniqueCourses }
    end

    assert_redirected_to college_path(assigns(:college))
  end

  test "should show college" do
    get :show, id: @college
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @college
    assert_response :success
  end

  test "should update college" do
    put :update, id: @college, college: { id: @college.id, israelStudyAbroad: @college.israelStudyAbroad, jewishCourses: @college.jewishCourses, jewishMajor: @college.jewishMajor, jewishMinor: @college.jewishMinor, jewishPopGrad: @college.jewishPopGrad, jewishPopUndergrad: @college.jewishPopUndergrad, name: @college.name, popGrad: @college.popGrad, popUndergrad: @college.popUndergrad, programsOfStudy: @college.programsOfStudy, studyAbroad: @college.studyAbroad, uniqueCourses: @college.uniqueCourses }
    assert_redirected_to college_path(assigns(:college))
  end

  test "should destroy college" do
    assert_difference('College.count', -1) do
      delete :destroy, id: @college
    end

    assert_redirected_to colleges_path
  end
end
