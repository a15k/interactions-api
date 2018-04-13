require 'open-uri'
require 'fileutils'

desc <<-DESC.strip_heredoc
  Generate the Ruby API model bindings in the app/bindings directory.  swagger-codegen
  must be installed.  Run like `rake generate_model_bindings[1]` for version 1 API.
DESC
task :generate_model_bindings, [:api_major_version] => :environment do |tt,args|
  api_major_version = args[:api_major_version] || '1'
  output_dir = nil
  gem_name = 'interactions_api_models'

  SwaggerCodegen.execute(api_major_version) do |json|
    api_exact_version = json[:info][:version]
    output_dir = "#{Rails.application.root}/tmp/ruby-models/#{api_exact_version}"
    {
      cmd_options: %w[-l ruby -D models],
      output_dir: output_dir,
      config: {
        gemName: gem_name,
        gemHomepage: 'https://a15k.org/clients/ruby',
        gemRequiredRubyVersion: '>= 2.4',
        moduleName: "Api::V#{api_major_version}::Bindings",
        gemVersion: api_exact_version,
      }
    }
  end

  # Move the models to the app/bindings directory
  bindings_dir = "#{Rails.application.root}/app/bindings/api/v#{api_major_version}/bindings"
  FileUtils::rm_rf(bindings_dir)
  FileUtils::mkdir_p(bindings_dir)
  FileUtils::cp(Dir.glob("#{output_dir}/lib/#{gem_name}/models/*.rb"), bindings_dir, verbose: true)
end
