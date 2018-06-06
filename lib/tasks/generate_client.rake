require 'open-uri'
require 'fileutils'
require_relative '../swagger_codegen'

desc <<-DESC.strip_heredoc
  Generate an API client in the app/clients directory.  swagger-codegen
  must be installed.  Run like `rake generate_client[0,ruby]` for the
  version 0 Ruby API client.
DESC
task :generate_client, [:api_major_version, :language] => :environment do |tt,args|
  api_major_version = args[:api_major_version] || '1'
  language = args[:language]
  raise "Must specify a language, e.g. ruby" if language.nil?
  output_dir = nil

  SwaggerCodegen.execute(api_major_version) do |json|
    api_exact_version = json[:info][:version]
    output_dir = "#{Rails.application.root}/clients/#{api_exact_version}/#{language}"

    config = case language
    when "ruby"
      ruby_config(api_exact_version: api_exact_version)
    else
      raise "Don't know #{language} config options yet, see `swagger-codegen config-help -l #{language}"
    end

    # Clean out anything that use to be there so old bindings do come back to life
    FileUtils.rm_rf(output_dir)

    {
      cmd_options: %W[-l #{language}],
      output_dir: output_dir,
      config: config
    }
  end
end

def ruby_config(api_exact_version:)
  {
    gemName: 'a15k_interactions_api',
    gemHomepage: 'https://a15k.org/clients/ruby',
    gemRequiredRubyVersion: '>= 2.4',
    moduleName: "A15kInteractions",
    gemVersion: api_exact_version,
  }
end
