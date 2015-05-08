require 'sunra_utils/config/relay'
require 'sunra_utils/config/global'
require 'sunra_utils/config/uploader'
require 'sunra_utils/config/failsafe'
require 'sunra_utils/ps'
require 'sunra_utils/lockfile'
require "sunra_utils/rest_client"
require 'json'

class ServiceStatus
  # attr_accessible :title, :body
  #
  #
  def self.ffmpeg_relay_status
    status = { lock_file: false, capture: false, ffserver: false }
    config = Sunra::Utils::Config::Relay

    if File.exist?(config.lock_file)
      lock_file = Sunra::Utils::FFSRelayLockFile.new(config.lock_file)
      status[:lock_file] = true
    end

    return status unless lock_file

    status[:capture] = Sunra::Utils::PS::pid_exists?(lock_file.capture_pid)
    status[:ffserver] = Sunra::Utils::PS::pid_exists?(lock_file.ffserver_pid)
    status[:uptime] = (Time.now.utc - File.mtime(config.lock_file))/60

    status
  end

  def self.recording_service_status
    status = { project_id: nil,
               booking_id: nil,
               studio_id: nil,
               start_time: nil,
               end_time: nil }

    config = Sunra::Utils::Config::Global
    status[:recorders] = {}
    #config.recording_formats.each { |fmt| status[:recorders][fmt.upcase] = nil }

    rc = Sunra::Utils::RestClient.new(config.recording_service_rest_api_url,
                                      config.api_key,
                                      'api_key')

    status[:start_url] = "#{config.recording_service_rest_api_url}/start/?api_key=#{config.api_key}"
    status[:stop_url] = "#{config.recording_service_rest_api_url}/stop/?api_key=#{config.api_key}"

    begin
      json = JSON.parse(rc.get('/status/'))

      status[:running] = true
      status[:project_id] = json['project_id']
      status[:booking_id] = json['booking_id']
      status[:studio_id] = json['studio_id']
      status[:start_time] = json['start_time']
      status[:end_time] = json['end_time']
      status[:is_recording] = json['is_recording']

      json['recorders'].each do |rec|
        status[:recorders][rec['format'].upcase] = rec['is_recording']
      end
    rescue
      status[:running] = false
    end

    status
  end

  def self.uploader_service_status
    status = {}
    status[:pending] = []
    config = Sunra::Utils::Config::Uploader

    rc = Sunra::Utils::RestClient.new(config.uploader_service_url,
                                      '',
                                      'api_key')
    begin
      a_rc = Sunra::Utils::RestClient.new(config.archive_server_rest_url,
                                      '',
                                      'api_key')

      json = JSON.parse(rc.get('status.json')) # NB /status until the api_key is

      status[:archive_server] = :up
    rescue
      status[:archive_server] = :down
    end

    begin
      json = JSON.parse(rc.get('status')) # NB /status until the api_key is
                                           # used, then becomes /status/
      status[:running] = true
      status[:local] = json['uploading']['local']
      status[:remote] = json['uploading']['remote']
      status[:size] = json['uploading']['size']
      status[:bytes_written] = json['uploading']['bytes_written']
      status[:complete] = json['uploading']['complete']

      json['pending'].each do |p|
        status[:pending] << { project_name: p['project_name'],
                              client_name: p['client_name'],
                              base_filename: p['base_filename'],
                              format: p['format'] }
      end
    rescue
      status[:running] = false
    end

    status
  end

  def self.failsafe_service_status
    # check the lock file /tmp/failsafe.lck, check the pid and
    # then check when the last recoding in the failsafe recording
    # directory was made
    status = { lock_file: false, capture: false  }
    config = Sunra::Utils::Config::Failsafe.new

    # TODO: lock file should really be in the config
    if File.exist?('/tmp/failsafe.lock')
      lock_file = Sunra::Utils::FFSRelayLockFile.new('/tmp/failsafe.lock')
      status[:lock_file] = true
    else
      return status
    end

    # TODO: The order of pids in the lockfile is different
    status[:capture] = Sunra::Utils::PS::pid_exists?(lock_file.pids[0])

    recordings = Dir["#{config.storage_dir}/*"].sort_by{ |f| File.mtime(f) }
    size = Dir["#{config.storage_dir}/*"].reduce(0) { |acc, f| acc += File.stat(f).size  }

    status[:latest_recording] = recordings.last
    status[:first_recording] = recordings.first
    status[:recording_count] = recordings.size
    status[:recording_size] = size/1024/1024

    status
  end

end
