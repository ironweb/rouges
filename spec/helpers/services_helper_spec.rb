require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ServicesHelper. For example:
#
# describe ServicesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ServicesHelper do

  service = Struct.new(:code, :name, :description).new("servicecode", "Service Name", "description")

  describe "service name" do

    it "generates service name from metadata" do
      config = {
        'services' => [{
          'service_code' => "servicecode",
          'name' => "Trottoir a reparer",
        }]
      }
      Easy311::Rails.stub(:load_config).and_return(config)

      name = service_name(service)
      name.should == "Trottoir a reparer"
    end

    it "uses service name when no metadata" do
      config = {'services' => []}
      Easy311::Rails.stub(:load_config).and_return(config)

      name = service_name(service)
      name.should == service.name
    end

  end

  describe "service css class" do

    it "generates a css class if there isn't any in metadata" do
      config = {'services' => []}
      Easy311::Rails.stub(:load_config).and_return(config)

      css_class = service_css_class(service)
      css_class.should == "service-name"
    end

    it "generates service css class from metadata" do
      config = {
        'services' => [{
          'service_code' => "servicecode",
          'css_class' => 'cssclass',
        }]
      }
      Easy311::Rails.stub(:load_config).and_return(config)

      css_class = service_css_class(service)
      css_class.should == 'cssclass'
    end

  end

  describe "service description" do

    it "generates a description if there isn't any metadata" do
      config = {'services' => []}
      Easy311::Rails.stub(:load_config).and_return(config)

      desc = service_desc(service)
      desc.should == service.description
    end

    it "generates a description from metadata" do
      config = {
        'services' => [{
          'service_code' => "servicecode",
          'description' => 'huge description',
        }]
      }
      Easy311::Rails.stub(:load_config).and_return(config)

      desc = service_desc(service)
      desc.should == 'huge description'
    end
  end

end
