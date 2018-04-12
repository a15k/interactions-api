require_relative '../swagger_codegen'

namespace :generate_client do

  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the tmp directory
  DESC
  task :ruby, [:api_major_version] => :environment do |tt,args|

    SwaggerCodegen.execute(args[:api_major_version] || '1') do |json|
      {
        cmd_options: '-l ruby -Dmodels',
        output_dir: "#{Rails.application.root}/tmp/ruby-client",
        config: {
          gemName: 'a15k-interactions',
          moduleName: 'A15K::Interactions',
          gemVersion: json[:info][:version]
        }
      }
    end

  end

end
