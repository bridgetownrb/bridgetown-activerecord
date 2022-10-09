# frozen_string_literal: true

require_relative "./helper"

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

class TestBridgetownActiverecord < Bridgetown::TestCase
  def setup
    @config = Bridgetown.configuration(
      "root_dir"    => root_dir,
      "source"      => source_dir,
      "destination" => dest_dir,
      "quiet"       => true
    )
    @config.run_initializers! context: :static
    @site = Bridgetown::Site.new(@config)
  end

  context "sample plugin" do
    setup do
      with_metadata title: "My Awesome Site" do
        @site.process
        @contents = File.read(dest_dir("index.html"))
      end
    end

    should "connect to the database" do
      assert_includes @contents, "ActiveRecord::ConnectionAdapters::PostgreSQLAdapter"
    end
  end
end
