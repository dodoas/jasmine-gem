# require 'phantomjs'
require "socket"

module Jasmine
  module Runners
    class ChromeHeadless
      def initialize(formatter, jasmine_server_url, config)
        @formatter = formatter
        @jasmine_server_url = jasmine_server_url
        @config = config
        @show_console_log = @config.show_console_log
        @show_full_stack_trace = @config.show_full_stack_trace
        @ferrum_browser_options = @config.ferrum_browser_options || {}
      end

      def run
        begin
          require "ferrum"
        rescue LoadError => e
          raise 'Add "ferrum" you your Gemfile. To use chromeheadless we require this gem.'
        end

        browser = Ferrum::Browser.new(@ferrum_browser_options)
        result_recived = false

        browser.on("Runtime.consoleAPICalled") do |params|
          if params["type"] == "log"
            if params["args"][0] && params["args"][0]["value"] == "jasmine_spec_result"
              results = JSON.parse(params["args"][1]["value"], :max_nesting => false)
                            .map { |r| Result.new(r.merge!("show_full_stack_trace" => @show_full_stack_trace)) }
              formatter.format(results)
            elsif params["args"][0] && params["args"][0]["value"] == "jasmine_suite_result"
              results = JSON.parse(params["args"][1]["value"], :max_nesting => false)
                            .map { |r| Result.new(r.merge!("show_full_stack_trace" => @show_full_stack_trace)) }
              failures = results.select(&:failed?)
              if failures.any?
                formatter.format(failures)
              end
            elsif params["args"][0] && params["args"][0]["value"] == "jasmine_done"
              result_recived = true
              run_details = JSON.parse(params["args"][1]["value"], :max_nesting => false)
              formatter.done(run_details)
            elsif show_console_log
              puts params["args"].map { |e| e["value"] }.join(' ')
            end
          end
        end

        browser.goto(jasmine_server_url)

        loop do
          sleep 1
          break if result_recived
        end

        browser.quit
      end

      def boot_js
        File.expand_path('chromeheadless_boot.js', File.dirname(__FILE__))
      end

      private
      attr_reader :formatter, :jasmine_server_url, :show_console_log, :config
    end
  end
end
