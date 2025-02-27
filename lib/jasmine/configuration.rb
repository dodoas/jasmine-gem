module Jasmine
  class Configuration
    attr_writer :jasmine_css_files, :css_files
    attr_writer :jasmine_files, :boot_files, :src_files, :runner_boot_files
    attr_accessor :helper_files, :spec_files
    attr_accessor :jasmine_path, :spec_path, :boot_path, :src_path, :image_path, :runner_boot_path
    attr_accessor :jasmine_dir, :spec_dir, :boot_dir, :src_dir, :images_dir, :runner_boot_dir
    attr_accessor :formatters
    attr_accessor :color
    attr_accessor :host
    attr_accessor :spec_format
    attr_accessor :runner
    attr_accessor :rack_options
    attr_accessor :show_console_log
    attr_accessor :stop_spec_on_expectation_failure
    attr_accessor :stop_on_spec_failure
    attr_accessor :random
    attr_accessor :ferrum_browser_options
    attr_accessor :show_full_stack_trace
    attr_accessor :runner_browser
    attr_reader :rack_apps

    def initialize()
      @rack_paths = {}
      @rack_apps = []
      @path_mappers = []
      @jasmine_css_files = lambda { [] }
      @css_files = lambda { [] }
      @jasmine_files = lambda { [] }
      @boot_files = lambda { [] }
      @runner_boot_files = lambda { [] }
      @src_files = lambda { [] }
      @helper_files = lambda { [] }
      @spec_files = lambda { [] }
      @testing_files = lambda { helper_files.call + spec_files.call}
      @runner = lambda { |config| }
      @rack_options = {}
      @show_console_log = false
      @stop_spec_on_expectation_failure = false
      @stop_on_spec_failure = false
      @random = true
      @ferrum_browser_options = {
        headless: true,
        browser_options: {
          'no-sandbox' => nil,
        }
      }
      @runner_browser = :chromeheadless

      @formatters = [Jasmine::Formatters::Console]
      @color = true

      @server_port = 8888
    end

    def css_files
      map(@jasmine_css_files, :jasmine) +
        map(@css_files, :src)
    end

    def js_files
      map(@jasmine_files, :jasmine) +
        map(@boot_files, :boot) +
        map(@runner_boot_files, :runner_boot) +
        map(@src_files, :src) +
        map(@testing_files, :spec)
    end

    def rack_path_map
      {}.merge(@rack_paths)
    end

    def add_rack_path(path, rack_app_lambda)
      @rack_paths[path] = rack_app_lambda
    end

    def add_rack_app(app, *args, &block)
      @rack_apps << {
          :app => app,
          :args => args,
          :block => block
      }
    end

    def add_path_mapper(mapper)
      @path_mappers << mapper.call(self)
    end

    def server_port=(port)
      @server_port = port
    end

    def ci_port=(port)
      @ci_port = port
    end

    def port(server_type)
      if server_type == :server
        @server_port
      else
        @ci_port ||= Jasmine.find_unused_port
      end
    end

    def host
      @host || 'http://localhost'
    end

    private

    def map(path_procs, type)
      @path_mappers.inject(path_procs.call) do |paths, mapper|
        if mapper.respond_to?("map_#{type}_paths")
          mapper.send("map_#{type}_paths", paths)
        else
          paths
        end
      end
    end

  end
end
