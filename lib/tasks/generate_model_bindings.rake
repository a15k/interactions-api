require 'open-uri'
require 'fileutils'

desc <<-DESC.strip_heredoc
  Generate the Ruby API model bindings in the app/bindings directory.  swagger-codegen
  must be installed.  Run like `rake generate_model_bindings[1]` for version 1 API.
DESC
task :generate_model_bindings, [:api_major_version] => :environment do |tt,args|
  api_major_version = args[:api_major_version]

  swagger_data = Swagger::Blocks.build_root_json(
    "Docs::V#{api_major_version}Controller::SWAGGERED_CLASSES".constantize
  )

  api_exact_version = swagger_data[:info][:version]

  output_dir = "#{Rails.application.root}/tmp/ruby-models/#{api_exact_version}"
  FileUtils::rm_rf(output_dir)
  FileUtils::mkdir_p(output_dir)

  swagger_json_file_name = "#{output_dir}/swagger.json"

  File.open(swagger_json_file_name, "w") {|f| f.write(swagger_data.to_json)}

  gem_name = "interactions_api_models"

  config_file_name = "#{output_dir}/config.json"
  config_file = File.open(config_file_name, "w") do |file|
    contents = <<-DESC.strip_heredoc
      {
        "gemName": "#{gem_name}",
        "moduleName": "Api::V#{api_major_version}::Bindings",
        "gemVersion": "#{api_exact_version}"
      }
    DESC
    file.write(contents)
  end

  swagger_json_url = "#{Rails.application.secrets.base_url}/api/docs/v#{api_major_version}"

  cmd = <<-DESC.strip_heredoc
    swagger-codegen generate -i #{swagger_json_file_name} \
    -l ruby -Dmodels -o #{output_dir} -c #{config_file_name}
  DESC

  puts cmd
  `#{cmd}`

  File.delete(config_file_name)

  bindings_dir = "#{Rails.application.root}/app/bindings/api/v#{api_major_version}/bindings"
  FileUtils::rm_rf(bindings_dir)
  FileUtils::mkdir_p(bindings_dir)

  FileUtils::cp(Dir.glob("#{output_dir}/lib/#{gem_name}/models/*.rb"), bindings_dir, verbose: true)
end
