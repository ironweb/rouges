require 'open311_helper'

describe "RequestsController", :type => :feature do
  describe "GET new" do
    context "with invalid service" do
      it "raises routing error" do
        expect { visit request_path('one_service') }.to raise_exception(ActionController::RoutingError)
      end
    end

    context "with a valid service" do
      def stub_service(attributes)
        RequestsController.any_instance.stub(:service) do
          FactoryGirl.build(:open311_service, :attrs => attributes)
        end
      end

      after(:each) { RequestsController.any_instance.unstub(:service) }

      it "returns a form with one field per attr" do
        stub_service [
          FactoryGirl.build(:open311_attribute, :code => "desc", :datatype => "string"),
          FactoryGirl.build(:open311_attribute, :code => "phone", :datatype => "text")
        ]
        visit request_path('one_service')
        within '#new_request' do
          page.should have_selector('.control-group', :count => 2)
        end
      end

    end
  end
end
