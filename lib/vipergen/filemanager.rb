module Vipergen
	# File manager class
	class FileManager

		# Returns if the template is valid by the VIPER generator 
		def self.is_template_valid(template)
			return Vipergen::TemplateManager.templates.include? template
		end

		# Returns if the language is valid by the VIPER generator
		def self.is_language_valid(language)
			return (Vipergen::Generator::LANGUAGES).include? language
		end

		# Return the path if valid template and language
		# @return String with valid path 
		def self.path_from(template, language)
			return nil if !is_language_valid(language) || !is_template_valid(template)
			return File.join(Vipergen::TemplateManager.templates_dir, template, language)
		end

		# Returns an array with files in a given path
		# @return Array with the files in a given path
		def self.files_in_path(path)
			return Dir[File.join("#{path}","/**/*")].select {|f| File.file?(f)}
		end

		# Returns the destination viper path 
		# @return Destination root path
		def self.destination_viper_path(path, name)
			expand_path = File.expand_path(path)
			return File.join(expand_path,name)
		end

		# Copy a system item to another place
		def self.copy(from, to)
			to_expand_path = File.expand_path(to)
			from_expand_path = File.expand_path(from)
			FileUtils.mkdir_p (to_expand_path)
			FileUtils.copy_entry(from_expand_path, to_expand_path)	
		end

		# Move a system item to another place
		def self.move(from, to)
			to_expand_path = File.expand_path(to)
			from_expand_path = File.expand_path(from)
			FileUtils.move(from_expand_path, to_expand_path)
		end

	end
end