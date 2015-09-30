require 'thor'
require 'vipergen'

module Vipergen
  class ViperThor < Thor
	desc "generate", "Generate a VIPER module"
	option :language, :required => false, :default => 'objc', :type => :string, :desc => "The language of the generated module (swift, objc)"
	option :template, :required => false, :default => 'default', :type => :string , :desc => "Template for the generation"
	option :path, :required => true, :type => :string , :desc => "Path where the output module is going to be saved"
	option :author, :required => false, :default => 'VIPER', :type => :string , :desc => "Author to be specified on the file's header. Otherwise VIPER will be used"
    option :swift_module, :required => false, :default => 'VIPER', :type => :string , :desc => "Swift module name to be specified on the @testable directive. Otherwise VIPER will be used"
	def generate(name)
        Vipergen::Generator.generate_viper(options[:template], options[:language], name, options[:path], options[:author], options[:swift_module])
	end

	desc "templates", "Get a list of available templates"
	def templates()
		puts Vipergen::TemplateManager.templates_description()
	end
  end
end