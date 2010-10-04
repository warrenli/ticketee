# encoding: utf-8

require 'spec_helper'

def cannot_create_tickets!
  response.should redirect_to(project)
  flash[:alert].should eql(I18n.t("tickets.not_authorized_to_create_msg"))
end


describe TicketsController do
  before do
    stub_warden
  end

  let(:user) { User.create!(:email => "user@ticketee.com", :password => "password", :password_confirmation => "password") }
  let(:project) { Project.create!(:name => "Ticketee" ) }
  let(:ticket) { project.tickets.create(:title => "Restrict permissions", :description => "something happen", :user => user) }

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "standard users" do
      it "cannot access a ticket for a project they don't have access to" do
        sign_in_as(user)
        get :show, :id => ticket.id, :project_id => project.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("projects.not_found_msg"))
      end
    end

    context "user with permission to view the project" do
      before do
        sign_in_as(user)
        Permission.create(:user => user, :object => project, :action => "read")
      end

      it "cannot begin to create a ticket" do
        get :new, :project_id => project.id
        cannot_create_tickets!
      end

      it "cannot create a ticket without permission" do
        post :create, :project_id => project.id
        cannot_create_tickets!
      end
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    context "一般帳戶" do
      it "當沒有專案的閱讀權限是不可以存取專案的工作單 " do
        sign_in_as(user)
        get :show, :id => ticket.id, :project_id => project.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("projects.not_found_msg"))
      end
    end

    context "帳戶有閱讀權限專案" do
      before do
        sign_in_as(user)
        Permission.create(:user => user, :object => project, :action => "read")
      end

      it "不可以嘗試建立專案的工作單" do
        get :new, :project_id => project.id
        cannot_create_tickets!
      end

      it "沒有工作單建立權限是不能執行這個工作" do
        post :create, :project_id => project.id
        cannot_create_tickets!
      end
    end
  end
end
