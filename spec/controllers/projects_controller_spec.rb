# encoding: utf-8

require 'spec_helper'

describe ProjectsController do
  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    it "displays an error message when asked for a missing project" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      flash[:error].should eql(I18n.t("projects.not_found_msg"))
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    it "找不到專案時顯示錯誤信息" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      flash[:error].should eql(I18n.t("projects.not_found_msg"))
    end
  end
end
