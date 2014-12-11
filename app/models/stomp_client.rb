class StompClient
  extend Memoist

  def initialize(attrs)
    @username = attrs.fetch(:username)
    @password = attrs.fetch(:password)
    @host = attrs.fetch(:host)
    @port = attrs.fetch(:port)
    @topic = attrs.fetch(:topic)
    @client_id = Socket.gethostname
    @subscription_id = @client_id + '-' + SecureRandom.uuid
  end

  def get
    q = Queue.new
    connect
    subscribe do |msg|
      if msg.present?
        q.enq(msg.body)
        unsubscribe
      end
    end
    result = q.deq
    disconnect
    result
  end

  protected

  attr_reader :username, :password, :host, :port, :topic, :client_id, :subscription_id

  def client
    client_headers = { "accept-version" => "1.1", "heart-beat" => "5000,10000", "client-id" => client_id, "host" => host }
    client_hash = { :hosts => [ { :login => username, :passcode => password, :host => host, :port => port } ], :connect_headers => client_headers }
    Stomp::Client.new(client_hash)
  end

  memoize :client

  def subscribe(&block)
    client.subscribe(topic, { 'id' => client.uuid(), 'ack' => 'client', 'activemq.subscriptionName' => subscription_id }) do |msg|
      client.acknowledge(msg, msg.headers)
      block.call(msg)
    end
  end

  def unsubscribe
    client.join
  end

  def connect
    raise "Connection failed" unless client.open?
    raise "Connect error: #{client.connection_frame().body}" if client.connection_frame().command == Stomp::CMD_ERROR
    raise "Unexpected protocol level #{client.protocol}" unless client.protocol == Stomp::SPL_11
  end

  def disconnect
    client.close
  end
end
