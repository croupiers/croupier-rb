module Croupier
  module CLI
    #####################################################################
    # Croupier main command line interface application object.
    #
    # When invoking +croupier+ from the command line,
    # a Croupier::CLI::Application object is created and run.
    #
    class Application
      attr_accessor :distribution_list, :distributions_options

      # Initialize a Croupier::CLI::Application object.
      # It Checks and loads the available distributions.
      def initialize
        @distribution_list, @distributions_options = {}, {}
        ::Croupier::Distributions.all.each do |d|
          @distribution_list[d.cli_name] = d
          @distributions_options[d.cli_name] = d.cli_options
        end
      end

      # Run the Croupier application. The run method performs the following steps:
      #
      # * Parses the application options.
      # * Identifies the probability distribution, sample size and options to use.
      # * Asks the actual distribution to generate the numbers, and outputs them.
      def run
        Croupier.trap_interrupt
        distribution, sample_size, params = parse_distribution_options
        distribution.new(params).generate_sample(sample_size).each{|n| Croupier.message n}
      end

      private

      def parse_distribution_options
        #Trollop needs this vars locally
        available_distribution_list     = @distribution_list.keys
        available_distributions_options = @distributions_options
        version = ::Croupier::VERSION

        opts = Trollop::options do
          banner <<-EOS
Croupier will generate random numbers with the specified distribution.

Currently you can use this distributions:
[#{available_distribution_list.join(', ')}]

Usage:
  croupier <distribution> <n> [options]
   where <n> is the quantity of numbers Croupier will generate.

Get options list for any distribution with: croupier <distrib> --help

          EOS
          version "Croupier version #{version}"
          stop_on available_distribution_list
        end

        dist = ARGV.shift # get the distribution name
        dist_opts = case
        when available_distribution_list.include?(dist)
           Trollop::options do
             banner (available_distributions_options[dist][:banner] || "Options (#{dist}):")
             available_distributions_options[dist][:options].each{|ooo|
               opt ooo[0], ooo[1], ooo[2]
             }
           end
        else
          Trollop::die "unknown distribution #{dist.inspect}"
        end

        sample_size = ARGV.shift.to_i # get the sample size
        Trollop::die "Sample size must be a positive integer" if sample_size.nil? || sample_size < 1

        return [@distribution_list[dist], sample_size, dist_opts]
      end
    end
  end
end
