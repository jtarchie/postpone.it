require 'spec_helper'

describe VideosController do
  before do
    @user = users(:user)
    @video = videos(:video)
    sign_in @user
  end

  describe "GET#index" do
    before {get :index}
    it "should be successful" do
      response.should be_success
    end

    it "should have a list of all the users videos" do
      assigns(:videos).should == [@video]
    end
  end

  describe "GET#new" do
    before {get :new}
    it "should be successful" do
      response.should be_success
    end

    it "should assign have a new record" do
      assigns(:video).should be_new_record
    end
  end

  describe "GET#edit" do
    before {get :edit, :id => @video.id}
    it "should be successful" do
      response.should be_success
    end

    it "should assign the requested video" do
      assigns(:video).should == @video
    end
  end

  describe "POST#create" do
    def make_request(params={:video => Factory.attributes_for(:video, :url => "http://other.com/vid.mov")})
      post :create, params
    end
    context "with valid params" do
      it "should create a new record" do
        expect {
          make_request
        }.to change(Video, :count).by(1)
        video = Video.last
        video.url.should == "http://other.com/vid.mov"
      end

      it "should redirect back to the index page" do
        make_request
        response.should redirect_to(videos_path)
      end
    end
    context "with invalid params" do
      it "should show the errors" do
        make_request(:video => {:url => ""})
        response.should render_template("new")
        assigns(:video).should_not be_valid
      end
    end
  end

  describe "PUT#update" do
    def make_request(params={})
      put :update, params
    end
    context "with valid params" do
      it "should create a new record" do
        expect {
          make_request(:id => @video.id, :video => {:url => "http://other.com/video/mov"})
        }.should_not change(Video, :count).by(1)
        @video.reload.url.should == "http://other.com/video/mov"
      end

      it "should redirect back to the index page" do
        make_request(:id => @video.id, :video => {:url => "http://other.com/video/mov"})
        response.should redirect_to(videos_path)
      end
    end
    context "with invalid params" do
      it "should show the errors" do
        make_request(:id => @video.id, :video => {:url => ""})
        response.should render_template("edit")
        assigns(:video).should_not be_valid
      end
    end
  end

  describe "DELETE#destroy" do
    before {delete :destroy, :id => @video.id}
    it "should delete the video" do
      Video.find_by_id(@video.id).should be_nil
    end

    it "should redirect back to the index page" do
      response.should redirect_to(videos_path)
    end
  end
end
