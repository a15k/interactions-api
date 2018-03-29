require 'open-uri'
require 'fileutils'

namespace :generate_client do

  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the tmp directory
  DESC
  task ruby: :environment do
    raise "Not yet implemented"
  end

  desc <<-DESC.strip_heredoc
    Generate the Ruby API model bindings in the tmp directory
  DESC
  task :ruby_models, [:api_major_version] => :environment do |tt,args|
    swagger_json_url = "#{Rails.application.secrets.base_url}/api/docs/v#{args[:api_major_version]}"
    swagger_json = JSON.load(open(swagger_json_url))
    api_exact_version = swagger_json["info"]["version"]

    output_dir = "#{Rails.application.root}/tmp/ruby-models/#{api_exact_version}"
    FileUtils::mkdir_p(output_dir)

    config_file_name = "#{output_dir}/config.json"
    config_file = File.open(config_file_name, "w") do |file|
      contents = <<-DESC.strip_heredoc
        {
          "gemName": "interactions_api_models",
          "moduleName": "InteractionsApi",
          "gemVersion": "#{api_exact_version}"
        }
      DESC
      file.write(contents)
    end

    cmd = <<-DESC.strip_heredoc
      swagger-codegen generate -i #{swagger_json_url} \
      -l ruby -Dmodels -o #{output_dir} -c #{config_file_name}
    DESC

    puts cmd
    `#{cmd}`

    File.delete(config_file_name)
  end

end

