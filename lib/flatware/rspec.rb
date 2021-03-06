# frozen_string_literal: true

require 'rspec/core'
require 'rspec/expectations'
require 'flatware/rspec/cli'

module Flatware
  module RSpec
    require 'flatware/rspec/formatters/console'
    require 'flatware/rspec/formatter'
    require 'flatware/rspec/job_builder'

    def self.extract_jobs_from_args(args, workers:)
      JobBuilder.new(args, workers: workers).jobs
   end

    def self.run(job, _options = {})
      runner = ::RSpec::Core::Runner
      def runner.trap_interrupt() end

      args = %w[
        --format Flatware::RSpec::Formatter
      ] + Array(job)

      runner.run(args, $stderr, $stdout)
    end
  end
end
