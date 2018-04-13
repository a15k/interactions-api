require_relative '../swagger_codegen'

namespace :generate_client do

  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the tmp directory.
  DESC
  task :ruby, [:api_major_version] => :environment do |tt,args|

    output_dir = "#{Rails.application.root}/tmp/ruby-client"
    FileUtils::rm_rf(output_dir)

    SwaggerCodegen.execute(args[:api_major_version] || '1') do |json|
      {
        cmd_options: %w[-l ruby],
        output_dir: output_dir,
        config: {
          gemName: 'a15k_interactions',
          moduleName: 'A15kInteractions',
          gemVersion: json[:info][:version]
        }
      }
    end

  end

end
