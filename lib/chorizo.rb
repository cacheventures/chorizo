require 'yaml'

class Chorizo

  def initialize
    @host_names = %w(cloud66 heroku)
  end

  def load_config
    yml = YAML.load_file('./config/application.yml')
    hashes, base = yml.partition { |k,v| v.is_a?(Hash) }
    hashes = hashes.to_h
    base = base.to_h
    hosts = {}
    @host_names.each do |host|
      hosts[host] = hashes.delete(host) if hashes[host]
    end
    { base: base, hosts: hosts, envs: hashes } 
  end

  def build_output(env, host)
    configs = load_config
    output = configs[:base]

    # load environment config
    if configs[:envs][env]
      output.merge! configs[:envs][env]
    else
      STDERR.puts "WARNING: #{env} specific configuration not found".red
    end

    # load host config
    if configs[:hosts][host]
      hc = configs[:hosts][host]
      # load embedded env config in host config, if present
      hc_envs, hc_base = hc.partition { |k,v| v.is_a?(Hash) }
      hc_env = hc_envs.to_h[env]
      hc_output = hc_base.to_h
      hc_output.merge! hc_env if hc_env

      output.merge! hc_output
    else
      STDERR.puts "WARNING: #{host} specific configuration not found".red
    end

    output
  end

  def cloud66(env)
    output = build_output(env, 'cloud66')
    output.each do |k,v|
      value = decrypt_value(v)
      puts "#{k.upcase}=#{value}"
    end
  end

  def heroku(env, app)
    output = build_output(env, 'heroku')
    cmd_output = output.map do |k,v|
      value = decrypt_value(v)
      escaped_value = "#{v}".shellescape
      "#{k}=#{escaped_value}"
    end.join(' ')
    system "heroku config:set #{cmd_output} -a #{app}"
  end

  def decrypt_value(value)
    if value =~ /^ENC\[/
      Open3.popen2("eyaml", "decrypt", "-s", value) do |i, o, t|
        o.read.chomp
      end
    else
      value
    end
  end

end
