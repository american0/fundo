require 'simple_bdd/rspec'
require 'paperclip/matchers'
require 'webmock/rspec'


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before :each, [{type: :feature}, {db_seeds: true}] do
    load Rails.root.join('db/seeds.rb')
  end

  config.before :each do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.set_default_stub(
      [
        {"address_components"=>
          [{"long_name"=>"362", "short_name"=>"362", "types"=>["street_number"]},
           {"long_name"=>"Suydam Street", "short_name"=>"Suydam St", "types"=>["route"]},
           {"long_name"=>"Bushwick", "short_name"=>"Bushwick", "types"=>["neighborhood", "political"]},
           {"long_name"=>"Brooklyn", "short_name"=>"Brooklyn", "types"=>["political", "sublocality", "sublocality_level_1"]},
           {"long_name"=>"Kings County", "short_name"=>"Kings County", "types"=>["administrative_area_level_2", "political"]},
           {"long_name"=>"New York", "short_name"=>"NY", "types"=>["administrative_area_level_1", "political"]},
           {"long_name"=>"United States", "short_name"=>"US", "types"=>["country", "political"]},
           {"long_name"=>"11237", "short_name"=>"11237", "types"=>["postal_code"]},
           {"long_name"=>"2954", "short_name"=>"2954", "types"=>["postal_code_suffix"]}],
         "formatted_address"=>"362 Suydam St, Brooklyn, NY 11237, USA",
         "geometry"=>
          {"bounds"=>{"northeast"=>{"lat"=>40.7043447, "lng"=>-73.921184}, "southwest"=>{"lat"=>40.7042351, "lng"=>-73.9213449}},
           "location"=>{"lat"=>40.7042899, "lng"=>-73.9212644},
           "location_type"=>"ROOFTOP",
           "viewport"=>{"northeast"=>{"lat"=>40.7056388802915, "lng"=>-73.91991546970849}, "southwest"=>{"lat"=>40.7029409197085, "lng"=>-73.9226134302915}}},
         "place_id"=>"ChIJ-SpSVRxcwokRgcfCMb3b66g",
         "types"=>["premise"]}
      ]
    )
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  config.order = :random
  config.include Paperclip::Shoulda::Matchers

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

=end
end
