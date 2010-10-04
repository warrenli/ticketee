# encoding: utf-8

require 'spec_helper'
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
  end
end
