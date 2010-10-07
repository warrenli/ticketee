# encoding: utf-8

require 'spec_helper'

describe AssetsController do

  let(:project) { Project.create(:name => "Ticketee") }
  
  let(:good_user) { create_user! } 
  
  let(:bad_user) { create_user!(:email => "other_user@ticketee.com") }
  
  let(:ticket) do
    project.tickets.create(:title => "File attachment",
                           :description => "A wild file appears!")
  end
  
  let(:path) { Rails.root + "spec/fixtures/speed.txt" }
  
  let(:asset) do
    ticket.assets.create(:asset => File.open(path))
  end
  
  before do
    good_user.permissions.create!(:action => "read", :object => project)
  end

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "users with access" do
      before do
        sign_in(:user, good_user)
      end

      it "can access assets in a project" do
        get 'show', :id => asset.id
        response.body.should eql(File.read(path))
      end
    end

    context "users without access" do
      before do
       sign_in(:user, bad_user)
      end
      it "cannot access assets in this project" do
        get 'show', :id => asset.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("assets.cannot_show_msg"))
      end
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    context "帳戶有存取權限" do
      before do
        sign_in(:user, good_user)
      end

      it "可以取得專案的資產" do
        get 'show', :id => asset.id
        response.body.should eql(File.read(path))
      end
    end

    context "帳戶沒有存取權限" do
      before do
       sign_in(:user, bad_user)
      end
      it "不可以取得專案的資產" do
        get 'show', :id => asset.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("assets.cannot_show_msg"))
      end
    end
  end
end
