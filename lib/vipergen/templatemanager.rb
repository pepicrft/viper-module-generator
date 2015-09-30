require 'yaml'
module Vipergen
	class TemplateManager

		# Returns the templates dir
	    def self.templates_dir
	      t = "#{Gem.dir}/gems/#{Vipergen::NAME}-#{Vipergen::VERSION}/lib/templates"
	    end

		# Get the available templates paths
		# @return Array[String] with available templates paths
		def self.templates_paths()
			template_dir = Vipergen::TemplateManager.templates_dir
			return Vipergen::DirUtils.directories_in(template_dir)
		end

		# Get the templates names
		# @return Array[String] with templates names (got from the folder)
		def self.templates()
			templates_paths.map{|template_path| template_name_from_path(template_path)}
		end

		# Returns the template name from a given template_path
		# @return String with the template name
		def self.template_name_from_path(template_path)
			return template_path.split("/").last
		end

		# Returns the description of all the templates available
		# @return String with the entire description
		def self.templates_description()
			description = "\nAvailable templates \n"
			description += "------------------- \n"
			self.templates_paths.each do |template_path|
				description += "> #{template_description(template_path)} \n"
			end
			return description
		end

		# Returns the description of a given template
		# @param template String with the template path whose description is going to be returned
		# @return String with the template description
		def self.template_description(template_path)
			template_description = ""

			# Reading yaml
			template_content = YAML.load_file(File.join(template_path,'viperspec.yml'))

			# Generating string
			template_description+= "| #{template_name_from_path(template_path)} by #{template_content["author"]} |: #{template_content["template_description"]}"
		end
	end
end