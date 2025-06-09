class MockGoFishSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = @socket.read_nonblock(200_000)
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end