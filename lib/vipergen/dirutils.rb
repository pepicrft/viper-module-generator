module Vipergen
	class DirUtils
		# Return a directory with the project libraries.
	    def self.gem_libdir
	      t = ["#{File.dirname(File.expand_path($0))}/../lib/#{Vipergen::NAME}",
	           "#{Gem.dir}/gems/#{Vipergen::NAME}-#{Vipergen::VERSION}/lib/#{Vipergen::NAME}"]
	      t.each {|i| return i if File.readable?(i) }
	      raise "both paths are invalid: #{t}"
	    end

	    # Returns the directories inside a given one
	    def self.directories_in(directory)
	    	expanded_dir = File.expand_path(directory)
	    	return Dir.glob(File.join(expanded_dir,'*')).select {|f| File.directory? f}
	    end
	end
end