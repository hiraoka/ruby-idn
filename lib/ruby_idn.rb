require 'open3'
require 'shellwords'

class RubyIdn
  attr_accessor :name

  def initialize(name: )
    @name = name
  end

  def name=(str)
    @name = str
  end

  def ascii_name
    self.class.to_ascii(name)
  end

  def unicode_name
    self.class.to_unicode(name)
  end

  class << self
    def to_ascii(domain)
      ret_domain = to_stringprep(domain)
      call_idn(domain: ret_domain, options: '-a')
    end

    def to_unicode(domain)
      ret_domain = to_stringprep(domain)
      call_idn(domain: ret_domain, options: '-u')
    end

    def to_stringprep(domain)
      call_idn(domain: domain, options: '-s')
    end

    def to_nameprep(domain)
      call_idn(domain: domain, options: ['-p', 'Nameprep'])
    end

    private

    def call_idn( domain:, options: )
      return domain if domain.nil? || domain.empty?
      opts = ["idn", options, "--quiet", domain]
      opts.flatten!

      stdout, stderr, _ = Open3.capture3(opts.shelljoin)
      unless stderr.empty?
        error = delete_unnecessary_char_for_error(stderr)
        raise IdnError, error
      end
      domain = stdout.chomp.downcase
    end

    def delete_unnecessary_char_for_error(error_message)
      error_message =~ /idn: (.*)\n/
      $1
    end
  end
end

class IdnError < StandardError; end
